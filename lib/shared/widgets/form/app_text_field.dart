import 'package:flutter/material.dart';

import '../../design_system/app_dimensions.dart';
import '../../design_system/responsive_dimensions.dart';
import '../../design_system/responsive_typography.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final int maxLines;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppDimensions.breakpointMd;

    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      maxLines: maxLines,
      enabled: enabled,
      style: ResponsiveTypography.getBodyText(context),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha:0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha:0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainer.withValues(alpha:0.3),
        contentPadding: EdgeInsets.symmetric(
          horizontal: ResponsiveDimensions.getSpacing(context, 16),
          vertical: ResponsiveDimensions.getSpacing(context, isMobile ? 12 : 16),
        ),
        labelStyle: ResponsiveTypography.getLabel(context),
        hintStyle: ResponsiveTypography.getBodyText(context).copyWith(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha:0.6),
        ),
      ),
    );
  }
}