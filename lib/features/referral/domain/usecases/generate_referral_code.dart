import 'package:jenosize_loyalty_app/features/referral/domain/repositories/referral_repository.dart';

class GenerateReferralCode {
  final ReferralRepository repository;

  GenerateReferralCode(this.repository);

  Future<String> call() async {
    return await repository.generateReferralCode();
  }
}