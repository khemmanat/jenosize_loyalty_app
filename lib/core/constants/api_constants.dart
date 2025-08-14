class ApiConstants {
  static const String baseUrl = 'http://localhost:3000/api';

  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String me = '/auth/me';
  static const String logout = '/auth/logout';

  // Campaign endpoints
  static const String campaigns = '/campaigns';
  static String joinCampaign(int id) => '/campaigns/$id/join';

  // Membership endpoints
  static const String membershipStatus = '/users/membership-status';
  static const String joinMembership = '/memberships/join';

  // Points endpoints
  static const String pointsBalance = '/points/balance';
  static const String pointsTransactions = '/points/transactions';
  static const String pointsSummary = '/points/summary';

  // Referral endpoints
  static const String myReferralCode = '/referrals/my-code';
  static String applyReferralCode(String code) => '/referrals/apply/$code';
  static const String referralStats = '/referrals/stats';

  // Headers
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';
}