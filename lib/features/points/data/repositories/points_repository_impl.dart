import '../../domain/entities/point_transaction.dart';
import '../../domain/repositories/points_repository.dart';
import '../datasources/local/datasources/points_local_data_source.dart';

class PointsRepositoryImpl implements PointsRepository {
  final PointsLocalDataSource localDataSource;

  PointsRepositoryImpl({required this.localDataSource});

  @override
  Future<int> getPointsBalance() async {
    return await localDataSource.getPointsBalance();
  }

  @override
  Future<List<PointTransaction>> getTransactionHistory() async {
    return await localDataSource.getTransactionHistory();
  }

  @override
  Future<void> addPoints(int points, String description) async {
    return await localDataSource.addPoints(points, description);
  }
}