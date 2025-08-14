import 'package:flutter/material.dart';
import 'package:jenosize_loyalty_app/shared/design_system/app_dimensions.dart';
import 'package:jenosize_loyalty_app/shared/design_system/responsive_dimensions.dart';
import 'package:jenosize_loyalty_app/shared/design_system/responsive_typography.dart';

class ResponsiveEmptyState extends StatelessWidget {
  const ResponsiveEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

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
            // Empty State Icon
            Container(
              padding: EdgeInsets.all(
                ResponsiveDimensions.getSpacing(context, 32),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: ResponsiveDimensions.getIconSize(context, 64),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            SizedBox(height: ResponsiveDimensions.getSpacing(context, 24)),

            // Title
            Text(
              title,
              style: ResponsiveTypography.getHeading2(context).copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: ResponsiveDimensions.getSpacing(context, 12)),

            // Message
            Text(
              message,
              style: ResponsiveTypography.getBodyText(context).copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),

            if (actionLabel != null && onAction != null) ...[
              SizedBox(height: ResponsiveDimensions.getSpacing(context, 32)),

              // Action Button
              SizedBox(
                width: isMobile ? double.infinity : 200,
                height: ResponsiveDimensions.getButtonHeight(context),
                child: FilledButton(
                  onPressed: onAction,
                  style: FilledButton.styleFrom(
                    textStyle: ResponsiveTypography.getButton(context),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                    ),
                  ),
                  child: Text(actionLabel!),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}