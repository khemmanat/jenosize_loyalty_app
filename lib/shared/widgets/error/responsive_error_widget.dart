import 'package:flutter/material.dart';
import 'package:jenosize_loyalty_app/shared/design_system/app_dimensions.dart';
import 'package:jenosize_loyalty_app/shared/design_system/responsive_dimensions.dart';
import 'package:jenosize_loyalty_app/shared/design_system/responsive_typography.dart';

class ResponsiveErrorWidget extends StatelessWidget {
  const ResponsiveErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
    this.icon = Icons.error_outline,
    this.title,
  });

  final String message;
  final VoidCallback onRetry;
  final IconData icon;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppDimensions.breakpointMd;
    final padding = ResponsiveDimensions.getPagePadding(context);

    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: isMobile ? double.infinity : 400,
        ),
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error Icon
            Container(
              padding: EdgeInsets.all(
                ResponsiveDimensions.getSpacing(context, 24),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: ResponsiveDimensions.getIconSize(context, 64),
                color: Theme.of(context).colorScheme.error,
              ),
            ),

            SizedBox(height: ResponsiveDimensions.getSpacing(context, 24)),

            // Error Title
            Text(
              title ?? 'Something went wrong',
              style: ResponsiveTypography.getHeading2(context).copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: ResponsiveDimensions.getSpacing(context, 12)),

            // Error Message
            Text(
              message,
              style: ResponsiveTypography.getBodyText(context).copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
              maxLines: isMobile ? 4 : 6,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: ResponsiveDimensions.getSpacing(context, 32)),

            // Retry Button
            SizedBox(
              width: isMobile ? double.infinity : 200,
              height: ResponsiveDimensions.getButtonHeight(context),
              child: FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                style: FilledButton.styleFrom(
                  textStyle: ResponsiveTypography.getButton(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}