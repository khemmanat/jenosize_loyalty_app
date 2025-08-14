import 'package:dio/dio.dart';

sealed class Failure {
  final String message;

  const Failure(this.message);
}

class NetworkFailure extends Failure {
  final int? code;

  const NetworkFailure(super.message, {this.code});
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(super.message);
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure(super.message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

// Enhanced error handling utility
class ApiErrorHandler {
  static Failure handleDioError(dynamic error) {
    if (error is DioException) {
      switch (error.response?.statusCode) {
        case 400:
          return NetworkFailure(
            'Invalid request. Please check your input.',
            code: 400,
          );
        case 401:
          return const AuthenticationFailure(
            'Authentication required. Please log in again.',
          );
        case 403:
          return const ForbiddenFailure(
            'Access denied. You don\'t have permission for this action.',
          );
        case 404:
          return const NotFoundFailure(
            'The requested resource was not found.',
          );
        case 429:
          return NetworkFailure(
            'Too many requests. Please try again later.',
            code: 429,
          );
        case 500:
        case 502:
        case 503:
          return const ServerFailure(
            'Server error. Please try again later.',
          );
        default:
          return NetworkFailure(
            error.message ?? 'Network error occurred.',
            code: error.response?.statusCode,
          );
      }
    }

    return const UnexpectedFailure('An unexpected error occurred.');
  }

  static String getUserFriendlyMessage(Failure failure) {
    switch (failure.runtimeType) {
      case AuthenticationFailure _:
        return 'Please log in to continue';
      case ForbiddenFailure _:
        return 'Access denied';
      case NotFoundFailure _:
        return 'Content not found';
      case ServerFailure _:
        return 'Server temporarily unavailable';
      case NetworkFailure _:
        final networkFailure = failure as NetworkFailure;
        if (networkFailure.code == 429) {
          return 'Please wait a moment before trying again';
        }
        return 'Check your internet connection';
      default:
        return 'Something went wrong';
    }
  }
}
