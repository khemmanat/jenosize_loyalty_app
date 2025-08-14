import 'package:flutter/material.dart';
import 'package:jenosize_loyalty_app/shared/design_system/responsive_dimensions.dart';
import 'package:jenosize_loyalty_app/shared/design_system/responsive_typography.dart';

import '../../design_system/app_dimensions.dart';

class ResponsiveLoadingCard extends StatefulWidget {
  const ResponsiveLoadingCard({
    super.key,
    this.height,
    this.title,
    this.showPulse = true,
  });

  final double? height;
  final String? title;
  final bool showPulse;

  @override
  State<ResponsiveLoadingCard> createState() => _ResponsiveLoadingCardState();
}

class _ResponsiveLoadingCardState extends State<ResponsiveLoadingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    if (widget.showPulse) {
      _controller.repeat();
    }
    _animation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveDimensions.getPagePadding(context);
    final cardHeight = widget.height ?? ResponsiveDimensions.getCardHeight(context);

    return Container(
      height: cardHeight,
      margin: EdgeInsets.symmetric(horizontal: padding.left),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
      ),
      child: widget.showPulse
          ? AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => _buildContent(context),
      )
          : _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: ResponsiveDimensions.getIconSize(context, 24),
          height: ResponsiveDimensions.getIconSize(context, 24),
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: widget.showPulse
                ? Theme.of(context).colorScheme.primary.withOpacity(_animation.value)
                : Theme.of(context).colorScheme.primary,
          ),
        ),
        if (widget.title != null) ...[
          SizedBox(height: ResponsiveDimensions.getSpacing(context, 16)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveDimensions.getSpacing(context, 24),
            ),
            child: Text(
              widget.title!,
              style: ResponsiveTypography.getBodyText(context).copyWith(
                color: widget.showPulse
                    ? Theme.of(context).colorScheme.onSurface.withOpacity(_animation.value)
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );
  }
}
