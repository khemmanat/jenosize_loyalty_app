import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/result.dart';
import '../../domain/entities/campaign.dart';
import 'campaign_local_data_source.dart';

class CampaignsLocalDataSourceImpl implements CampaignsLocalDataSource {
  final SharedPreferences prefs;

  CampaignsLocalDataSourceImpl(this.prefs);

  static const _k = 'campaigns.page1';

  @override
  Future<Result<void>> cacheList(List<Campaign> items) async {
    final json = items
        .map((c) => {
              'id': c.id,
              'title': c.title,
              'description': c.description,
              'imageUrl': c.imageUrl,
              'ctaText': c.ctaText,
              'ctaUrl': c.ctaUrl,
              'rewardPoints': c.rewardPoints,
              'isActive': c.isActive,
              'createdAt': c.createdAt.toIso8601String(),
              'startsAt': c.startsAt?.toIso8601String(),
              'endsAt': c.endsAt?.toIso8601String(),
            })
        .toList();
    await prefs.setString(_k, jsonEncode(json));
    return const Ok(null);
  }

  @override
  Future<Result<List<Campaign>>> getCachedList() async {
    final raw = prefs.getString(_k);
    if (raw == null) return const Ok([]);
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    final items = list
        .map((j) => Campaign(
              id: j['id'],
              title: j['title'],
              description: j['description'],
              imageUrl: j['imageUrl'],
              ctaText: j['ctaText'],
              ctaUrl: j['ctaUrl'],
              rewardPoints: j['rewardPoints'],
              isActive: j['isActive'],
              createdAt: DateTime.parse(j['createdAt']).toUtc(),
              startsAt: j['startsAt'] != null ? DateTime.parse(j['startsAt']).toUtc() : null,
              endsAt: j['endsAt'] != null ? DateTime.parse(j['endsAt']).toUtc() : null,
            ))
        .toList();
    return Ok(items);
  }
}
