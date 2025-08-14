import 'package:jenosize_loyalty_app/features/points/domain/repositories/points_repository.dart';

import '../../../../core/errors/result.dart';

class RedeemPoints {
  final PointsRepository repo;

  RedeemPoints(this.repo);

  Future<Result<void>> call({required int points, String? description}) => repo.redeemPoints(points: points, description: description);
}
