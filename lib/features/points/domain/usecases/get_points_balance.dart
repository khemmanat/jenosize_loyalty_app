import 'package:jenosize_loyalty_app/features/points/domain/repositories/points_repository.dart';

class GetPointsBalance {
  final PointsRepository _pointsRepository;

  GetPointsBalance(this._pointsRepository);

  Future<int> call() async {
    return await _pointsRepository.getPointsBalance();
  }
}