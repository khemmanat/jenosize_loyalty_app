import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/result.dart';
import '../../../../shared/domain/value_objects.dart';
import '../../domain/entities/referral.dart';
import 'referral_local_data_source.dart';

class ReferralLocalDataSourceImpl implements ReferralLocalDataSource {
  final SharedPreferences prefs;

  ReferralLocalDataSourceImpl(this.prefs);

  static const _kCode = 'referral.code';
  static const _kHist = 'referral.history.p1';

  @override
  Future<Result<void>> cacheCode(String code) async {
    await prefs.setString(_kCode, code);
    return const Ok(null);
  }

  @override
  Future<Result<String?>> getCachedCode() async => Ok(prefs.getString(_kCode));

  @override
  Future<Result<void>> cacheHistory(List<Referral> items) async {
    final json = items
        .map((r) => {
              'code': r.code,
              'referrerId': r.referrerId,
              'referredUserId': r.referredUserId,
              'pointsAwarded': r.pointsAwarded,
              'status': r.status.name,
              'createdAt': r.createdAt.toIso8601String(),
            })
        .toList();
    await prefs.setString(_kHist, jsonEncode(json));
    return const Ok(null);
  }

  @override
  Future<Result<List<Referral>>> getCachedHistory() async {
    final raw = prefs.getString(_kHist);
    if (raw == null) return const Ok([]);
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    final items = list
        .map((j) => Referral(
              code: j['code'],
              referrerId: j['referrerId'],
              referredUserId: j['referredUserId'],
              pointsAwarded: j['pointsAwarded'],
              status: ReferralStatus.values.firstWhere((e) => e.name == j['status'], orElse: () => ReferralStatus.completed),
              createdAt: DateTime.parse(j['createdAt']).toUtc(),
            ))
        .toList();
    return Ok(items);
  }
}
