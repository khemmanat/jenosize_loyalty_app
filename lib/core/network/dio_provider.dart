import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_constants.dart';
import '../storage/shared_prefs_provider.dart';

const kDebugUserId = String.fromEnvironment('DEBUG_USER_ID', defaultValue: '11111111-1111-1111-1111-111111111111');

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: const String.fromEnvironment('BASE_URL', defaultValue: AppConstants.apiBaseUrl),
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 20),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  // Add authentication interceptor
  dio.interceptors.add(AuthInterceptor(ref));

  // Add logging interceptor (keep this for debugging)
  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    requestHeader: true,
    responseHeader: false, // Reduce log noise
  ));

  return dio;
});

class AuthInterceptor extends Interceptor {
  final Ref ref;

  AuthInterceptor(this.ref);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Use debug user ID for development
    options.headers['x-user-id'] = kDebugUserId;

    // Add access token if available
    final prefs = ref.read(sharedPreferencesProvider);
    final accessToken = prefs.getString('access_token');
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle authentication errors
    if (err.response?.statusCode == 401) {
      // Clear stored credentials and redirect to login
      _handleAuthenticationError();
    }

    super.onError(err, handler);
  }

  void _handleAuthenticationError() {
    final prefs = ref.read(sharedPreferencesProvider);
    prefs.remove('access_token');
    // In a real app, you would navigate to login screen here
  }
}