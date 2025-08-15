import '../../../../core/errors/failures.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/campaign.dart';
import '../../domain/entities/campaign_join_data.dart';
import '../../domain/entities/campaign_join_result.dart';
import '../../domain/repositories/campaign_repository.dart';
import '../../domain/services/joined_campaigns_service.dart';
import '../datasources/campaign_local_data_source.dart';
import '../datasources/campaign_remote_data_source.dart';

class CampaignsRepositoryImpl implements CampaignsRepository {
  final CampaignsRemoteDataSource remote;
  final CampaignsLocalDataSource local;
  final JoinedCampaignsService joined; // <- เพิ่ม

  CampaignsRepositoryImpl(this.remote, this.local, this.joined);

  @override
  Future<Result<List<Campaign>>> listCampaigns({int page = 1, int limit = 20}) async {
    final r = await remote.list(page: page, limit: limit);
    return r.fold(
      onSuccess: (dtos) async {
        final items = dtos.map((e) => e.toDomain()).toList();
        if (page == 1) {
          await local.cacheList(items);
        }
        return Ok(items);
      },
      onFailure: (f) async {
        if (page == 1) {
          final cached = await local.getCachedList();
          return cached.fold(onSuccess: (it) => it.isNotEmpty ? Ok(it) : Err(f), onFailure: (_) => Err(f));
        }
        return Err(f);
      },
    );
  }

  @override
  Future<Result<CampaignJoinResult>> joinCampaign(String campaignId) async {
    final r = await remote.join(campaignId);

    return r.fold(
      // เคส success จากเซิร์ฟเวอร์ (มี body ครบ)
      onSuccess: (res) async {
        await joined.markAsJoined(res.campaign.campaignId, res.campaign.joinedAt);
        return Ok(res);
      },

      // เคส failure: ถ้าเป็น EMPTY_JOIN_RESPONSE ให้สังเคราะห์ผลจากแคชหน้าแรก
      onFailure: (f) async {
        final isEmptyJoin = f is NetworkFailure && f.message == 'EMPTY_JOIN_RESPONSE';
        if (!isEmptyJoin) return Err(f);

        final cachedR = await local.getCachedList();
        return cachedR.fold(
          onSuccess: (list) async {
            // หา campaign จากแคชแบบไม่ใช้ package เสริม
            Campaign? found;
            for (final c in list) {
              if (c.id == campaignId) {
                found = c;
                break;
              }
            }
            if (found == null) {
              return const Err(UnexpectedFailure('Joined, but campaign not in cache. Pull to refresh.'));
            }

            final now = DateTime.now().toUtc();
            final synthesized = CampaignJoinResult(
              campaign: CampaignJoinData(
                campaignId: found.id,
                title: found.title,
                rewardPoints: found.rewardPoints,
                joinedAt: now,
              ),
              pointsEarned: found.rewardPoints,
              transaction: null,
              success: true,
              warning: 'Joined successfully (synthesized).',
            );

            await joined.markAsJoined(found.id, now);
            return Ok(synthesized);
          },
          onFailure: (_) => const Err(UnexpectedFailure('Join succeeded, but no details. Please refresh.')),
        );
      },
    );
  }

  @override
  Future<Result<Set<String>>> joinedCampaignIds() => joined.getJoinedIds();
}
