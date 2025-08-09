import 'package:flutter/material.dart';

import '../../domain/entities/campaign.dart';

class CampaignCard extends StatelessWidget {
  const CampaignCard({super.key, required this.campaign, this.onJoin});

  final Campaign campaign;
  final VoidCallback? onJoin;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(campaign.imageUrl, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  campaign.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(campaign.description),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Points Reward: ${campaign.pointsReward}'),
                    ElevatedButton(
                      onPressed: onJoin ?? () {},
                      child: Text(campaign.isJoined ? 'Joined' : 'Join'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
