import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/points_di.dart';
import '../../domain/entities/point_summary.dart';
import '../../domain/entities/point_transaction.dart';

class PointsCombined {
  final PointsSummary summary;
  final List<PointTransaction> transactions;

  PointsCombined({required this.summary, required this.transactions});
}

final pointsCombinedProvider = FutureProvider.autoDispose<PointsCombined>((ref) async {
  final getSummary = ref.read(getPointsSummaryProvider);
  final getTransaction = ref.read(getPointTransactionsProvider);
  final r1 = await getSummary();
  final r2 = await getTransaction(page: 1, limit: 50);
  debugPrint('PointsCombinedProvider: r1=$r1, r2=$r2');
  return r1.fold(
    onSuccess: (s) async => r2.fold(
      onSuccess: (tx) => PointsCombined(summary: s, transactions: tx),
      onFailure: (f) => throw Exception(f.message),
    ),
    onFailure: (f) => throw Exception(f.message),
  );
});
