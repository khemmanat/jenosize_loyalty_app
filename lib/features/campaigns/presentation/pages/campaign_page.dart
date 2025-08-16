import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenosize_loyalty_app/shared/shared.dart';
import '../../../points/presentation/providers/points_ui_providers.dart';
import '../../di/campaigns_di.dart';
import '../providers/campaign_ui_providers.dart';

class CampaignsPage extends ConsumerWidget {
  const CampaignsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncVMs = ref.watch(campaignsVMProvider);

    return AppScaffold(
      appBar: MainAppBar(title: 'Campaigns'),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(campaignsVMProvider),
        child: asyncVMs.when(
          data: (vms) => vms.isEmpty ? const _EmptyState() : _GridList(vms: vms, onJoin: (id) => _join(context, ref, id)),
          loading: () => const _GridSkeleton(),
          error: (e, st) => ErrorStateWidget.fromError(
            error: st,
            onRetry: () => ref.invalidate(campaignsVMProvider),
            route: '/campaigns',
            compact: true,
          ),
        ),
      ),
    );
  }

  Future<void> _join(BuildContext context, WidgetRef ref, String id) async {
    final join = ref.read(joinCampaignProvider);
    final r = await join(id);
    r.fold(
      onSuccess: (_) {
        context.showSuccessSnackBar('Joined campaign');
        ref.invalidate(campaignsVMProvider);
        ref.invalidate(pointsCombinedProvider);
      },
      onFailure: (failure) {
        debugPrint('Failed to join campaign: ${failure.message}');
        context.showErrorSnackBar('Couldn’t join this campaign.');
      },
    );
  }
}

class _GridList extends StatelessWidget {
  const _GridList({required this.vms, required this.onJoin});

  final List<CampaignCardVM> vms;
  final ValueChanged<String> onJoin;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final cross = c.maxWidth >= 900
          ? 3
          : c.maxWidth >= 600
              ? 2
              : 1;
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cross,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: cross == 1 ? 2.4 : 1.6,
        ),
        itemCount: vms.length,
        itemBuilder: (_, i) {
          final vm = vms[i];
          final cpn = vm.campaign;
          return Card(
            clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cpn.title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Expanded(child: Text(cpn.description, maxLines: 3, overflow: TextOverflow.ellipsis)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Chip(label: Text('+${cpn.rewardPoints} pts')),
                      const Spacer(),
                      if (vm.joined)
                        OutlinedButton.icon(onPressed: null, icon: const Icon(Icons.check), label: const Text('Joined'))
                      else
                        FilledButton.icon(onPressed: cpn.isActive ? () => onJoin(cpn.id) : null, icon: const Icon(Icons.redeem), label: Text(cpn.ctaText)),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

class _GridSkeleton extends StatelessWidget {
  const _GridSkeleton();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12),
      itemCount: 6,
      itemBuilder: (_, __) => const Card(child: Center(child: CircularProgressIndicator())),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.inbox_outlined, size: 56),
            const SizedBox(height: 8),
            Text('No campaigns for now', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            const Text('Pull to refresh or check back later.'),
          ],
        ),
      ),
    );
  }
}
