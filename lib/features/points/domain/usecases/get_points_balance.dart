import 'package:jenosize_loyalty_app/features/points/domain/repositories/points_repository.dart';

import '../../../../core/errors/result.dart';

class GetPointsBalance {
  final PointsRepository repo;

  GetPointsBalance(this.repo);

  Future<Result<int>> call() => repo.getBalance();
}
