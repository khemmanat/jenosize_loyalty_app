import 'package:flutter/material.dart';

import '../../design_system/responsive_dimensions.dart';

class ResponsiveScrollView extends StatelessWidget {
  const ResponsiveScrollView({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveDimensions.getPagePadding(context);

    return SingleChildScrollView(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}