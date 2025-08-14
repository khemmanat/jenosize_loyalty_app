import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../storage/shared_prefs_provider.dart';

abstract class UserIdService {
  String? getCurrentUserId();
  Future<void> setUserId(String userId);
  Future<void> clearUserId();
  Future<String> getOrCreateUserId();
}

class UserIdServiceImpl implements UserIdService {
  final SharedPreferences _prefs;

  UserIdServiceImpl(this._prefs);

  @override
  String? getCurrentUserId() {
    return _prefs.getString('user_id');
  }

  @override
  Future<void> setUserId(String userId) async {
    await _prefs.setString('user_id', userId);
  }

  @override
  Future<void> clearUserId() async {
    await _prefs.remove('user_id');
  }

  @override
  Future<String> getOrCreateUserId() async {
    String? userId = getCurrentUserId();

    if (userId == null) {
      // Generate a new user ID for testing
      userId = _generateUserId();
      await setUserId(userId);
    }

    return userId;
  }

  String _generateUserId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = (timestamp % 10000).toString().padLeft(4, '0');
    return 'test_user_$random';
  }
}

// Provider for UserIdService
final userIdServiceProvider = Provider<UserIdService>((ref) {
  return UserIdServiceImpl(ref.watch(sharedPreferencesProvider));
});

// Provider for current user ID
final currentUserIdProvider = FutureProvider<String>((ref) async {
  final service = ref.watch(userIdServiceProvider);
  return await service.getOrCreateUserId();
});