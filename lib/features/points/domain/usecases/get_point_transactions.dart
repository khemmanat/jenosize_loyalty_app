import 'package:jenosize_loyalty_app/features/points/domain/entities/point_transaction.dart';
import 'package:jenosize_loyalty_app/features/points/domain/repositories/points_repository.dart';

import '../../../../core/errors/result.dart';

class GetPointTransactions {
  final PointsRepository repo;

  GetPointTransactions(this.repo);

  Future<Result<List<PointTransaction>>> call({int page = 1, int limit = 20}) => repo.getTransactions(page: page, limit: limit);
}
