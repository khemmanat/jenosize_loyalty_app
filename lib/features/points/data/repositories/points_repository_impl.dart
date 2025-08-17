import '../../../../core/errors/result.dart';
import '../../domain/entities/point_summary.dart';
import '../../domain/entities/point_transaction.dart';
import '../../domain/repositories/points_repository.dart';
import '../datasources/points_local_data_source.dart';
import '../datasources/points_remote_data_source.dart';

class PointsRepositoryImpl implements PointsRepository {
  final PointsRemoteDataSource remote;
  final PointsLocalDataSource local;

  PointsRepositoryImpl(this.remote, this.local);

  @override
  Future<Result<int>> getBalance() async {
    final r = await remote.getBalance();
    return r.fold(
      onSuccess: (b) async {
        await local.cacheBalance(b);
        return Ok(b);
      },
      onFailure: (f) async {
        final cachedR = await local.getCachedBalance(); // Result<int?>
        return cachedR.fold(
          onSuccess: (cached) => cached != null ? Ok(cached) : Err(f),
          onFailure: (_) => Err(f),
        );
      },
    );
  }

  @override
  Future<Result<List<PointTransaction>>> getTransactions({int page = 1, int limit = 20}) async {
    final r = await remote.getTransactions(page: page, limit: limit);
    return r.fold(
      onSuccess: (dtos) async {
        final txs = dtos.map((e) => e.toDomain()).toList();
        if (page == 1) {
          await local.cacheTransactions(txs);
        }
        return Ok(txs);
      },
      onFailure: (f) async {
        if (page == 1) {
          final cachedR = await local.getCachedTransactions(); // Result<List<PointTransaction>>
          return cachedR.fold(
            onSuccess: (cached) => cached.isNotEmpty ? Ok(cached) : Err(f),
            onFailure: (_) => Err(f),
          );
        }
        return Err(f);
      },
    );
  }

  @override
  Future<Result<PointsSummary>> getSummary() async {
    final r = await remote.getSummary();
    return r.fold(
      onSuccess: (dto) async {
        final domain = PointsSummary(
          totalPoints: dto.totalPoints,
          earnedThisMonth: dto.earnedThisMonth.abs(),
          spentThisMonth: dto.spentThisMonth.abs(),
          recentTransactions: const [], // เติมถ้ามีใน API
        );
        await local.cacheSummary(domain.totalPoints, domain.earnedThisMonth, domain.spentThisMonth);
        return Ok(domain);
      },
      onFailure: (f) async => Err(f),
    );
  }

  @override
  Future<Result<void>> redeemPoints({required int points, String? description}) => remote.redeemPoints(points: points, description: description);
}
