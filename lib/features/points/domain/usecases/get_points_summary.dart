import 'package:jenosize_loyalty_app/features/points/domain/entities/point_summary.dart';
import 'package:jenosize_loyalty_app/features/points/domain/repositories/points_repository.dart';

import '../../../../core/errors/result.dart';

class GetPointsSummary {
  final PointsRepository repo;

  GetPointsSummary(this.repo);

  Future<Result<PointsSummary>> call() => repo.getSummary();
}
