class StorageKeys {
  // Secure storage keys (flutter_secure_storage)
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';

  // Shared preferences keys
  static const String isFirstLaunch = 'is_first_launch';
  static const String lastSyncTime = 'last_sync_time';
  static const String userPreferences = 'user_preferences';

  // Cache keys
  static const String cachedCampaigns = 'cached_campaigns';
  static const String cachedMembership = 'cached_membership';
  static const String cachedPointsBalance = 'cached_points_balance';
  static const String cachedUser = 'cached_user';

  // App state keys
  static const String themeMode = 'theme_mode';
  static const String selectedLanguage = 'selected_language';
}