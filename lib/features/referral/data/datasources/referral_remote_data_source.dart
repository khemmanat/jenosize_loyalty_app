import '../../../../core/errors/result.dart';
import '../models/referral_dto.dart';

abstract class ReferralRemoteDataSource {
  Future<Result<String>> getMyCode();
  Future<Result<void>> apply(String code);
  Future<Result<List<ReferralDto>>> history({required int page, required int limit});
}