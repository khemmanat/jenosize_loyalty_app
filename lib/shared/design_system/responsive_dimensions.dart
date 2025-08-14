import 'package:flutter/material.dart';

import 'app_dimensions.dart';

class ResponsiveDimensions {
  // Get responsive spacing
  static double getSpacing(BuildContext context, double baseSpacing) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppDimensions.breakpointLg) {
      return baseSpacing * 1.2; // 20% larger on desktop
    } else if (screenWidth >= AppDimensions.breakpointMd) {
      return baseSpacing; // Base spacing on tablet
    } else {
      return baseSpacing * 0.8; // 20% smaller on mobile
    }
  }

  // Get responsive page padding
  static EdgeInsets getPagePadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppDimensions.breakpointLg) {
      // Desktop: More padding for better content centering
      return const EdgeInsets.symmetric(horizontal: 32, vertical: 24);
    } else if (screenWidth >= AppDimensions.breakpointMd) {
      // Tablet: Medium padding
      return const EdgeInsets.symmetric(horizontal: 24, vertical: 20);
    } else {
      // Mobile: Minimal padding to maximize content space
      return const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
    }
  }

  // Get responsive card height
  static double getCardHeight(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppDimensions.breakpointLg) {
      return 220.0; // Taller cards on desktop
    } else if (screenWidth >= AppDimensions.breakpointMd) {
      return 200.0; // Medium height on tablet
    } else {
      return 180.0; // Shorter cards on mobile
    }
  }

  // Get responsive grid columns
  static int getGridColumns(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppDimensions.breakpointLg) {
      return 3; // 3 columns on desktop
    } else if (screenWidth >= AppDimensions.breakpointMd) {
      return 2; // 2 columns on tablet
    } else {
      return 1; // 1 column on mobile
    }
  }

  // Get responsive button height
  static double getButtonHeight(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppDimensions.breakpointMd) {
      return AppDimensions.buttonHeightLg; // 48px on tablet/desktop
    } else {
      return AppDimensions.buttonHeightMd; // 40px on mobile
    }
  }

  // Get responsive icon size
  static double getIconSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppDimensions.breakpointLg) {
      return baseSize * 1.2;
    } else if (screenWidth >= AppDimensions.breakpointMd) {
      return baseSize;
    } else {
      return baseSize * 0.8;
    }
  }
}