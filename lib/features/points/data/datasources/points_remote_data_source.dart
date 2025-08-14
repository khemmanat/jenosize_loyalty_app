import '../../../../core/errors/result.dart';
import '../models/point_transaction_dto.dart';
import '../models/points_summary_dto.dart';

abstract class PointsRemoteDataSource {
  Future<Result<int>> getBalance();
  Future<Result<List<PointTransactionDto>>> getTransactions({required int page, required int limit});
  Future<Result<PointsSummaryDto>> getSummary();
  Future<Result<void>> redeemPoints({required int points, String? description});
}