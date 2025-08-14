import '../../../../core/errors/result.dart';
import '../../domain/entities/referral.dart';

abstract class ReferralLocalDataSource {
  Future<Result<void>> cacheCode(String code);
  Future<Result<String?>> getCachedCode();

  Future<Result<void>> cacheHistory(List<Referral> items); // หน้าแรก
  Future<Result<List<Referral>>> getCachedHistory();
}
