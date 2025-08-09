import 'package:jenosize_loyalty_app/features/points/domain/entities/point_transaction.dart';
import 'package:jenosize_loyalty_app/features/points/domain/repositories/points_repository.dart';

class GetTransactionHistory {

  final PointsRepository repository;

  GetTransactionHistory(this.repository);

  Future<List<PointTransaction>> call() async {
    return await repository.getTransactionHistory();
  }
}