import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/design_system/responsive_typography.dart';
import '../../../../shared/widgets/common/error_state_widget.dart';
import '../../../points/presentation/providers/points_ui_providers.dart';
import '../../di/campaigns_di.dart';
import '../../domain/entities/campaign.dart';
import '../providers/campaign_ui_providers.dart';

class CampaignsPage extends ConsumerWidget {
  const CampaignsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(campaignsPage1Provider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: Text(
          'Campaigns',
          style: ResponsiveTypography.getHeading1(context).copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(campaignsPage1Provider),
        color: Theme.of(context).colorScheme.primary,
        child: asyncItems.when(
          data: (items) => items.isEmpty
              ? _EmptyState(onRefresh: () => ref.invalidate(campaignsPage1Provider))
              : _GridList(
                  items: items,
                  onJoin: (id) => _join(context, ref, id),
                  onRefresh: () => ref.invalidate(campaignsPage1Provider),
                ),
          loading: () => const _GridSkeleton(),
          error: (e, _) => ErrorState(message: e.toString(), onRetry: () => ref.invalidate(campaignsPage1Provider)),
        ),
      ),
    );
  }

  Future<void> _join(BuildContext context, WidgetRef ref, String id) async {
    // Show loading indicator
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            ),
            SizedBox(width: 12),
            Text('Joining campaign...'),
          ],
        ),
        duration: Duration(seconds: 1),
      ),
    );

    final join = ref.read(joinCampaignProvider);
    final r = await join(id);

    r.fold(onSuccess: (_) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('Successfully joined campaign! 🎉'),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      ref.invalidate(campaignsPage1Provider);
      ref.invalidate(pointsCombinedProvider);
    }, onFailure: (f) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(child: Text('Failed: ${f.message}')),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    });
  }
}

class _GridList extends StatelessWidget {
  const _GridList({
    required this.items,
    required this.onJoin,
    required this.onRefresh,
  });

  final List<Campaign> items;
  final ValueChanged<String> onJoin;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final crossAxisCount = constraints.maxWidth >= 900
          ? 3
          : constraints.maxWidth >= 600
              ? 2
              : 1;

      return CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final campaign = items[index];
                  return _CampaignCard(
                    campaign: campaign,
                    onJoin: () => onJoin(campaign.id),
                    aspectRatio: crossAxisCount == 1 ? 2.2 : 1.4,
                  );
                },
                childCount: items.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: crossAxisCount == 1 ? 2.2 : 1.4,
              ),
            ),
          ),
        ],
      );
    });
  }
}

class _CampaignCard extends StatefulWidget {
  const _CampaignCard({
    required this.campaign,
    required this.onJoin,
    required this.aspectRatio,
  });

  final Campaign campaign;
  final VoidCallback onJoin;
  final double aspectRatio;

  @override
  State<_CampaignCard> createState() => _CampaignCardState();
}

class _CampaignCardState extends State<_CampaignCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getTimeRemaining() {
    if (widget.campaign.endsAt == null) return '';

    final now = DateTime.now();
    final endTime = widget.campaign.endsAt!;

    if (now.isAfter(endTime)) return 'Expired';

    final difference = endTime.difference(now);

    if (difference.inDays > 0) {
      return '${difference.inDays}d left';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h left';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m left';
    } else {
      return 'Ending soon';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final timeRemaining = _getTimeRemaining();
    final isExpired = widget.campaign.endsAt != null && DateTime.now().isAfter(widget.campaign.endsAt!);
    final isAvailable = widget.campaign.isActive && !isExpired;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Card(
            elevation: _isPressed ? 8 : 2,
            shadowColor: colorScheme.shadow.withOpacity(0.1),
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Could navigate to campaign details
                },
                onTapDown: (_) {
                  setState(() => _isPressed = true);
                  _controller.forward();
                },
                onTapUp: (_) {
                  setState(() => _isPressed = false);
                  _controller.reverse();
                },
                onTapCancel: () {
                  setState(() => _isPressed = false);
                  _controller.reverse();
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isAvailable
                          ? [
                              colorScheme.primaryContainer,
                              colorScheme.surfaceContainer,
                            ]
                          : [
                              colorScheme.surfaceContainer,
                              colorScheme.surfaceContainerHigh,
                            ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with status badge
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.campaign.title,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: isAvailable ? colorScheme.onPrimaryContainer : colorScheme.onSurface.withOpacity(0.6),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (!isAvailable)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: colorScheme.errorContainer,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  isExpired ? 'EXPIRED' : 'INACTIVE',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: colorScheme.onErrorContainer,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Description
                        Expanded(
                          child: Text(
                            widget.campaign.description,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: isAvailable ? colorScheme.onSurface : colorScheme.onSurface.withOpacity(0.6),
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Time remaining (if available)
                        if (timeRemaining.isNotEmpty) ...[
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 14,
                                color: isExpired ? colorScheme.error : colorScheme.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                timeRemaining,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: isExpired ? colorScheme.error : colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],

                        // Bottom section with points and join button
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isAvailable ? colorScheme.primary.withOpacity(0.1) : colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isAvailable ? colorScheme.primary.withOpacity(0.3) : colorScheme.outline.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.stars,
                                    size: 16,
                                    color: isAvailable ? colorScheme.primary : colorScheme.onSurface.withOpacity(0.6),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '+${widget.campaign.rewardPoints} pts',
                                    style: theme.textTheme.labelMedium?.copyWith(
                                      color: isAvailable ? colorScheme.primary : colorScheme.onSurface.withOpacity(0.6),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            FilledButton.icon(
                              onPressed: isAvailable ? widget.onJoin : null,
                              icon: Icon(
                                isAvailable ? Icons.redeem : Icons.block,
                                size: 18,
                              ),
                              label: Text(
                                isAvailable ? widget.campaign.ctaText : 'Unavailable',
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                minimumSize: const Size(0, 36),
                                backgroundColor: isAvailable ? null : colorScheme.surfaceContainerHighest,
                                foregroundColor: isAvailable ? null : colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onRefresh});

  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.campaign,
                      size: 64,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'No campaigns available',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Check back later for exciting campaigns and rewards!',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  FilledButton.icon(
                    onPressed: onRefresh,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Refresh'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GridSkeleton extends StatelessWidget {
  const _GridSkeleton();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 900
            ? 3
            : constraints.maxWidth >= 600
                ? 2
                : 1;

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: crossAxisCount == 1 ? 2.2 : 1.4,
          ),
          itemCount: 6,
          itemBuilder: (context, index) => const _SkeletonCard(),
        );
      },
    );
  }
}

class _SkeletonCard extends StatefulWidget {
  const _SkeletonCard();

  @override
  State<_SkeletonCard> createState() => _SkeletonCardState();
}

class _SkeletonCardState extends State<_SkeletonCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
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
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainer.withOpacity(_animation.value),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 14,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainer.withOpacity(_animation.value),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 14,
                  width: 200,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainer.withOpacity(_animation.value),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Container(
                      height: 32,
                      width: 80,
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainer.withOpacity(_animation.value),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 36,
                      width: 100,
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainer.withOpacity(_animation.value),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
