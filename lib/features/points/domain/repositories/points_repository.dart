import 'package:jenosize_loyalty_app/features/points/domain/entities/point_transaction.dart';

abstract class PointsRepository {
  Future<int> getPointsBalance();
  Future<List<PointTransaction>> getTransactionHistory();
  Future<void> addPoints(int points, String description);
}