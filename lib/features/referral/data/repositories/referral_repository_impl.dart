
import '../../../../core/errors/result.dart';
import '../../domain/entities/referral.dart';
import '../../domain/repositories/referral_repository.dart';
import '../datasources/referral_local_data_source.dart';
import '../datasources/referral_remote_data_source.dart';

class ReferralRepositoryImpl implements ReferralRepository {
  final ReferralRemoteDataSource remote;
  final ReferralLocalDataSource local;

  ReferralRepositoryImpl(this.remote, this.local);

  @override
  Future<Result<String>> getMyReferralCode() async {
    final r = await remote.getMyCode();
    return r.fold(
      onSuccess: (code) async { await local.cacheCode(code); return Ok(code); },
      onFailure: (f) async {
        final cached = await local.getCachedCode();
        return cached.fold(onSuccess: (c) => c != null ? Ok(c) : Err(f), onFailure: (_) => Err(f));
      },
    );
  }

  @override
  Future<Result<void>> applyReferralCode(String code) => remote.apply(code);

  @override
  Future<Result<List<Referral>>> getReferralHistory({int page = 1, int limit = 20}) async {
    final r = await remote.history(page: page, limit: limit);
    return r.fold(
      onSuccess: (dtos) async {
        final items = dtos.map((e) => e.toDomain()).toList();
        if (page == 1) { await local.cacheHistory(items); }
        return Ok(items);
      },
      onFailure: (f) async {
        if (page == 1) {
          final cached = await local.getCachedHistory();
          return cached.fold(onSuccess: (it) => it.isNotEmpty ? Ok(it) : Err(f), onFailure: (_) => Err(f));
        }
        return Err(f);
      },
    );
  }
}