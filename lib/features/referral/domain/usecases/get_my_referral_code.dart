import '../../../../core/errors/result.dart';
import '../repositories/referral_repository.dart';

class GetMyReferralCode {
  final ReferralRepository repo;

  GetMyReferralCode(this.repo);

  Future<Result<String>> call() => repo.getMyReferralCode();
}


