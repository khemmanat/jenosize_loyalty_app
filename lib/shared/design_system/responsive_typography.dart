import 'package:flutter/material.dart';

import 'app_dimensions.dart';

class ResponsiveTypography {
  // Get responsive heading styles
  static TextStyle getHeading1(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppDimensions.breakpointLg) {
      // Desktop: Larger text
      return const TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.2,
      );
    } else if (screenWidth >= AppDimensions.breakpointMd) {
      // Tablet: Medium text
      return const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.2,
      );
    } else {
      // Mobile: Smaller text for readability
      return const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        height: 1.2,
      );
    }
  }

  static TextStyle getHeading2(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppDimensions.breakpointLg) {
      return const TextStyle(fontSize: 28, fontWeight: FontWeight.w600, height: 1.3);
    } else if (screenWidth >= AppDimensions.breakpointMd) {
      return const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, height: 1.3);
    } else {
      return const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, height: 1.3);
    }
  }

  static TextStyle getHeading3(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppDimensions.breakpointLg) {
      return const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, height: 1.3);
    } else if (screenWidth >= AppDimensions.breakpointMd) {
      return const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, height: 1.3);
    } else {
      return const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, height: 1.3);
    }
  }

  static TextStyle getBodyText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppDimensions.breakpointMd) {
      return const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0.15,
      );
    } else {
      // Slightly smaller on mobile for better fit
      return const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.4,
        letterSpacing: 0.25,
      );
    }
  }

  static TextStyle getBodySmall(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppDimensions.breakpointMd) {
      return const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.4,
        letterSpacing: 0.25,
      );
    } else {
      return const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.3,
        letterSpacing: 0.4,
      );
    }
  }

  static TextStyle getLabel(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppDimensions.breakpointMd) {
      return const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      );
    } else {
      return const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      );
    }
  }

  static TextStyle getButton(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= AppDimensions.breakpointMd) {
      return const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      );
    } else {
      return const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      );
    }
  }
}
