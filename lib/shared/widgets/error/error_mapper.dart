import 'package:dio/dio.dart';

class ErrorPresentation {
  final String? title;
  final String message;
  final int? statusCode;
  const ErrorPresentation({this.title, required this.message, this.statusCode});
}

class ErrorMapper {
  static ErrorPresentation map(Object error, StackTrace? _st) {
    final status = _statusCode(error);
    final msg = error.toString();

    // Known buckets first
    if (_isNoInternet(msg)) {
      return ErrorPresentation(
        title: 'No internet',
        message: 'Please check your connection and try again.',
        statusCode: status,
      );
    }

    switch (status) {
      case 401:
        return const ErrorPresentation(title: 'Authentication required', message: 'Please sign in and try again.', statusCode: 401);
      case 403:
        return const ErrorPresentation(title: 'Permission denied', message: 'You don’t have access to this resource.', statusCode: 403);
      case 404:
        return const ErrorPresentation(title: 'Not found', message: 'We couldn’t find what you’re looking for.', statusCode: 404);
      case 408:
        return const ErrorPresentation(title: 'Timeout', message: 'The server took too long to respond.', statusCode: 408);
      case 500:
        return const ErrorPresentation(title: 'Server error', message: 'Something went wrong on our side.', statusCode: 500);
    }

    // Fallback
    return const ErrorPresentation(
      title: null,
      message: 'We couldn’t complete your request. Please try again.',
      statusCode: null,
    );
  }

  static int? _statusCode(Object e) {
    if (e is DioException) return e.response?.statusCode;
    // Add your Failure types here if you have them, e.g.:
    // if (e is NetworkFailure) return e.code;
    // if (e is ServerFailure) return e.statusCode;
    return null;
  }

  static bool _isNoInternet(String s) =>
      s.contains('SocketException') || s.contains('Failed host lookup') || s.contains('CONNECT_TIMEOUT');
}