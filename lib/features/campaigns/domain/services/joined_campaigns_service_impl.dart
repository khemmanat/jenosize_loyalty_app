import 'dart:convert';

import 'package:jenosize_loyalty_app/core/errors/failures.dart';
import 'package:jenosize_loyalty_app/core/errors/result.dart';
import 'package:jenosize_loyalty_app/features/campaigns/domain/services/joined_campaigns_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JoinedCampaignsServiceImpl implements JoinedCampaignsService {
  final SharedPreferences _prefs;
  static const String _key = 'joined_campaigns';

  JoinedCampaignsServiceImpl(this._prefs);

  @override
  Future<Result<void>> markAsJoined(String campaignId, DateTime joinedAt) async {
    try {
      final joined = await _getJoinedMap();
      joined[campaignId] = joinedAt.toIso8601String();
      await _prefs.setString(_key, jsonEncode(joined));
      return const Ok(null);
    } catch (e) {
      return Err(CacheFailure('Failed to mark as joined: $e'));
    }
  }

  @override
  Future<Result<Set<String>>> getJoinedIds() async {
    try {
      final joined = await _getJoinedMap();
      return Ok(joined.keys.toSet());
    } catch (e) {
      return Err(CacheFailure('Failed to get joined IDs: $e'));
    }
  }

  @override
  Future<Result<bool>> isJoined(String campaignId) async {
    try {
      final joined = await _getJoinedMap();
      return Ok(joined.containsKey(campaignId));
    } catch (e) {
      return Err(CacheFailure('Failed to check joined status: $e'));
    }
  }

  Future<Map<String, String>> _getJoinedMap() async {
    final rawData = _prefs.getString(_key);
    if (rawData == null) return {};

    try {
      final decoded = jsonDecode(rawData) as Map<String, dynamic>;
      return Map<String, String>.from(decoded);
    } catch (e) {
      await _prefs.remove(_key);
      return {};
    }
  }
}