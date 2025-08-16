import 'package:flutter/material.dart';

extension SnackBarExtension on BuildContext {
  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      AppSnackBar.success(message: message).build(),
    );
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      AppSnackBar.error(message: message).build(),
    );
  }

  void showSnackBarWithAction(
      String message,
      String actionLabel,
      VoidCallback onPressed,
      ) {
    ScaffoldMessenger.of(this).showSnackBar(
      AppSnackBar(
        message: message,
        actionLabel: actionLabel,
        onActionPressed: onPressed,
      ).build(),
    );
  }

  void clearSnackBars() {
    ScaffoldMessenger.of(this).clearSnackBars();
  }
}

class AppSnackBar {
  const AppSnackBar({
    required this.message,
    this.duration = const Duration(seconds: 3),
    this.actionLabel,
    this.onActionPressed,
    this.backgroundColor,
    this.textColor,
  });

  const AppSnackBar.success({
    required this.message,
    this.duration = const Duration(seconds: 3),
    this.actionLabel,
    this.onActionPressed,
  }) : backgroundColor = Colors.green,
        textColor = Colors.white;

  const AppSnackBar.error({
    required this.message,
    this.duration = const Duration(seconds: 4),
    this.actionLabel,
    this.onActionPressed,
  }) : backgroundColor = Colors.red,
        textColor = Colors.white;

  final String message;
  final Duration duration;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final Color? backgroundColor;
  final Color? textColor;

  SnackBar build() {
    return SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      duration: duration,
      backgroundColor: backgroundColor,
      action: actionLabel != null && onActionPressed != null
          ? SnackBarAction(
        label: actionLabel!,
        onPressed: onActionPressed!,
        textColor: textColor,
      )
          : null,
    );
  }
}