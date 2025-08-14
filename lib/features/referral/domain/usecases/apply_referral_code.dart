import '../../../../core/errors/result.dart';
import '../repositories/referral_repository.dart';

class ApplyReferralCode {
  final ReferralRepository repo;

  ApplyReferralCode(this.repo);

  Future<Result<void>> call(String code) => repo.applyReferralCode(code);
}

