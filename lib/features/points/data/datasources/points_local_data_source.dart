import '../../../../core/errors/result.dart';
import '../../domain/entities/point_transaction.dart';

abstract class PointsLocalDataSource {
  Future<Result<void>> cacheBalance(int value);
  Future<Result<int?>> getCachedBalance();
  Future<Result<void>> cacheTransactions(List<PointTransaction> txs);
  Future<Result<List<PointTransaction>>> getCachedTransactions();
  Future<Result<void>> cacheSummary(int total, int earnedThisMonth, int spentThisMonth);
}