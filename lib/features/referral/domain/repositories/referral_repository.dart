import '../../../../core/errors/result.dart';
import '../entities/referral.dart';

abstract class ReferralRepository {
  Future<Result<String>> getMyReferralCode();            // code
  Future<Result<void>> applyReferralCode(String code);   // ใช้โค้ด
  Future<Result<List<Referral>>> getReferralHistory({int page = 1, int limit = 20});
}