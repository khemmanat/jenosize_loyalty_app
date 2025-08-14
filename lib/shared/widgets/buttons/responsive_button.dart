import 'package:flutter/material.dart';

import '../../design_system/app_dimensions.dart';
import '../../design_system/responsive_dimensions.dart';
import '../../design_system/responsive_typography.dart';

enum ButtonVariant { filled, outlined, text }
enum ButtonSize { small, medium, large }

class ResponsiveButton extends StatelessWidget {
  const ResponsiveButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = ButtonVariant.filled,
    this.size = ButtonSize.medium,
    this.fullWidth = false,
    this.icon,
    this.loading = false,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool fullWidth;
  final Widget? icon;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    // final isMobile = MediaQuery.of(context).size.width < AppDimensions.breakpointMd;
    final height = _getHeight(context);
    final textStyle = _getTextStyle(context);

    Widget button;

    if (loading) {
      button = _buildLoadingButton(context, height, textStyle);
    } else {
      switch (variant) {
        case ButtonVariant.filled:
          button = _buildFilledButton(context, height, textStyle);
          break;
        case ButtonVariant.outlined:
          button = _buildOutlinedButton(context, height, textStyle);
          break;
        case ButtonVariant.text:
          button = _buildTextButton(context, height, textStyle);
          break;
      }
    }

    if (fullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }

  double _getHeight(BuildContext context) {
    switch (size) {
      case ButtonSize.small:
        return ResponsiveDimensions.getButtonHeight(context) * 0.8;
      case ButtonSize.medium:
        return ResponsiveDimensions.getButtonHeight(context);
      case ButtonSize.large:
        return ResponsiveDimensions.getButtonHeight(context) * 1.2;
    }
  }

  TextStyle _getTextStyle(BuildContext context) {
    return ResponsiveTypography.getButton(context);
  }

  Widget _buildFilledButton(BuildContext context, double height, TextStyle textStyle) {
    if (icon != null) {
      return SizedBox(
        height: height,
        child: FilledButton.icon(
          onPressed: onPressed,
          icon: icon!,
          label: child,
          style: FilledButton.styleFrom(
            textStyle: textStyle,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          textStyle: textStyle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          ),
        ),
        child: child,
      ),
    );
  }

  Widget _buildOutlinedButton(BuildContext context, double height, TextStyle textStyle) {
    if (icon != null) {
      return SizedBox(
        height: height,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: icon!,
          label: child,
          style: OutlinedButton.styleFrom(
            textStyle: textStyle,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          textStyle: textStyle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          ),
        ),
        child: child,
      ),
    );
  }

  Widget _buildTextButton(BuildContext context, double height, TextStyle textStyle) {
    if (icon != null) {
      return SizedBox(
        height: height,
        child: TextButton.icon(
          onPressed: onPressed,
          icon: icon!,
          label: child,
          style: TextButton.styleFrom(
            textStyle: textStyle,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          textStyle: textStyle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          ),
        ),
        child: child,
      ),
    );
  }

  Widget _buildLoadingButton(BuildContext context, double height, TextStyle textStyle) {
    return SizedBox(
      height: height,
      child: FilledButton(
        onPressed: null,
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(width: 8),
            child,
          ],
        ),
      ),
    );
  }
}