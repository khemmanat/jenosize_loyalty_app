import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenosize_loyalty_app/shared/widgets/app_bottom_navigation.dart';
import 'package:jenosize_loyalty_app/shared/widgets/app_scaffold.dart';

import '../providers/campaign_provider.dart';
import '../widgets/campaign_card.dart';

class CampaignPage extends ConsumerWidget {
  const CampaignPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campaignState = ref.watch(campaignProvider);
    final campaignNotifier = ref.read(campaignProvider.notifier);
    return AppScaffold(
      appBar: AppBar(
        title: const Text('Jenosize Loyalty'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
            onPressed: () => campaignNotifier.loadCampaigns(),
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: _buildBody(context, campaignState, campaignNotifier),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: 0,
      ),
    );
  }

  Widget _buildBody(BuildContext context, CampaignState state, CampaignNotifier notifier) {
    if (state.isLoading && state.campaigns.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.campaigns.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: ${state.error}', textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => notifier.loadCampaigns(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => notifier.loadCampaigns(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Available Campaigns',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              if (state.isLoading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
            ],
          ),
          if (state.error != null)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Error: ${state.error}',
                style: TextStyle(color: Colors.red.shade700),
              ),
            ),
          const SizedBox(height: 16),
          ...state.campaigns.map(
            (campaign) => CampaignCard(
              campaign: campaign,
              onJoin: () async {
                await notifier.joinCampaign(campaign.id);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Joined ${campaign.title}!'),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
