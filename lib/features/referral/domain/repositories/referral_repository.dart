abstract class ReferralRepository {
  Future<String> generateReferralCode();
  Future<void> shareReferral(String code);
}