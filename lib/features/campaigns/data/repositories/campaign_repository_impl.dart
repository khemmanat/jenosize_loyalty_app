import '../../../../core/errors/result.dart';
import '../../domain/entities/campaign.dart';
import '../../domain/repositories/campaign_repository.dart';
import '../datasources/campaign_local_data_source.dart';
import '../datasources/campaign_remote_data_source.dart';

class CampaignsRepositoryImpl implements CampaignsRepository {
  final CampaignsRemoteDataSource remote;
  final CampaignsLocalDataSource local;
  CampaignsRepositoryImpl(this.remote, this.local);

  @override
  Future<Result<List<Campaign>>> listCampaigns({int page = 1, int limit = 20}) async {
    final r = await remote.list(page: page, limit: limit);
    return r.fold(
      onSuccess: (dtos) async {
        final items = dtos.map((e) => e.toDomain()).toList();
        if (page == 1) { await local.cacheList(items); }
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
  Future<Result<void>> joinCampaign(String campaignId) => remote.join(campaignId);
}