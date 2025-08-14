import 'package:jenosize_loyalty_app/features/points/domain/entities/point_summary.dart';
import 'package:jenosize_loyalty_app/features/points/domain/entities/point_transaction.dart';

import '../../../../core/errors/result.dart';

abstract class PointsRepository {
  Future<Result<int>> getBalance();
  Future<Result<List<PointTransaction>>> getTransactions({int page = 1, int limit = 20});
  Future<Result<PointsSummary>> getSummary();
  Future<Result<void>> redeemPoints({required int points, String? description});
}