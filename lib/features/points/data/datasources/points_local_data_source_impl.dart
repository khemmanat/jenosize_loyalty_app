import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/result.dart';
import '../../../../shared/domain/value_objects.dart';
import '../../domain/entities/point_transaction.dart';
import 'points_local_data_source.dart';

class PointsLocalDataSourceImpl implements PointsLocalDataSource {
  final SharedPreferences prefs;

  PointsLocalDataSourceImpl(this.prefs);

  static const _kBalance = 'points.balance';
  static const _kTxs = 'points.txs';
  static const _kSummary = 'points.summary';

  @override
  Future<Result<void>> cacheBalance(int v) async {
    await prefs.setInt(_kBalance, v);
    return const Ok(null);
  }

  @override
  Future<Result<int?>> getCachedBalance() async => Ok(prefs.getInt(_kBalance));

  @override
  Future<Result<void>> cacheTransactions(List<PointTransaction> txs) async {
    final json = txs
        .map((e) => {
              'id': e.id,
              'userId': e.userId,
              'points': e.points,
              'type': e.type.name,
              'description': e.description,
              'referenceId': e.referenceId,
              'createdAt': e.createdAt.toIso8601String(),
            })
        .toList();
    await prefs.setString(_kTxs, jsonEncode(json));
    return const Ok(null);
  }

  @override
  Future<Result<List<PointTransaction>>> getCachedTransactions() async {
    final raw = prefs.getString(_kTxs);
    if (raw == null) return const Ok([]);
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    final txs = list
        .map((j) => PointTransaction(
              id: j['id'],
              userId: j['userId'],
              points: j['points'],
              type: pointTypeFromString(j['type']),
              description: j['description'],
              referenceId: j['referenceId'],
              createdAt: DateTime.parse(j['createdAt']).toUtc(),
            ))
        .toList();
    return Ok(txs);
  }

  @override
  Future<Result<void>> cacheSummary(int total, int earnedThisMonth, int spentThisMonth) async {
    await prefs.setString(_kSummary, jsonEncode({'total': total, 'earned': earnedThisMonth, 'spent': spentThisMonth}));
    return const Ok(null);
  }
}
