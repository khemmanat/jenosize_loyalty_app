import 'package:jenosize_loyalty_app/features/referral/domain/repositories/referral_repository.dart';

class ShareReferral {
  final ReferralRepository repository;

  ShareReferral(this.repository);

  Future<void> call(String referralCode) async {
    await repository.shareReferral(referralCode);
  }
}