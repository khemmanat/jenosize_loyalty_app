import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimensions.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary500,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primary100,
      onPrimaryContainer: AppColors.primary900,
      secondary: AppColors.secondary500,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.secondary100,
      onSecondaryContainer: AppColors.secondary900,
      surface: AppColors.surfacePrimary,
      onSurface: AppColors.neutral900,
      surfaceContainer: AppColors.surfaceSecondary,
      surfaceContainerHigh: AppColors.surfaceTertiary,
      surfaceContainerHighest: AppColors.neutral100,
      surfaceContainerLow: AppColors.neutral50,
      surfaceContainerLowest: AppColors.backgroundPrimary,
      error: AppColors.error,
      onError: Colors.white,
      errorContainer: Color(0xFFFFEBEE),
      onErrorContainer: Color(0xFFB71C1C),
      outline: AppColors.neutral300,
      outlineVariant: AppColors.neutral200,
      shadow: AppColors.neutral900,
    ),
    textTheme: const TextTheme(
      displayLarge: AppTypography.h1,
      displayMedium: AppTypography.h2,
      displaySmall: AppTypography.h3,
      headlineLarge: AppTypography.h1,
      headlineMedium: AppTypography.h2,
      headlineSmall: AppTypography.h3,
      titleLarge: AppTypography.h4,
      titleMedium: AppTypography.labelLarge,
      titleSmall: AppTypography.labelMedium,
      bodyLarge: AppTypography.bodyLarge,
      bodyMedium: AppTypography.bodyMedium,
      bodySmall: AppTypography.bodySmall,
      labelLarge: AppTypography.labelLarge,
      labelMedium: AppTypography.labelMedium,
      labelSmall: AppTypography.labelSmall,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTypography.h4,
      iconTheme: IconThemeData(color: AppColors.neutral900),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: AppTypography.buttonMedium,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        textStyle: AppTypography.buttonMedium,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        ),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: AppDimensions.elevation2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
      ),
      color: AppColors.surfacePrimary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        borderSide: const BorderSide(color: AppColors.neutral300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        borderSide: const BorderSide(color: AppColors.neutral300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        borderSide: const BorderSide(color: AppColors.primary500, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingLg,
        vertical: AppDimensions.spacingMd,
      ),
    ),
  );

  static ThemeData get darkTheme => lightTheme.copyWith(
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary400,
      onPrimary: AppColors.neutral900,
      primaryContainer: AppColors.primary800,
      onPrimaryContainer: AppColors.primary100,
      secondary: AppColors.secondary400,
      onSecondary: AppColors.neutral900,
      secondaryContainer: AppColors.secondary800,
      onSecondaryContainer: AppColors.secondary100,
      surface: AppColors.neutral900,
      onSurface: AppColors.neutral100,
      surfaceContainer: AppColors.neutral800,
      surfaceContainerHigh: AppColors.neutral700,
      surfaceContainerHighest: AppColors.neutral600,
      surfaceContainerLow: AppColors.neutral900,
      surfaceContainerLowest: Colors.black,
      error: AppColors.error,
      onError: Colors.white,
      outline: AppColors.neutral600,
      outlineVariant: AppColors.neutral700,
      shadow: Colors.black,
    ),
  );
}
