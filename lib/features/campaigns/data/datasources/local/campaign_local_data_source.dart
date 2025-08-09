import 'package:jenosize_loyalty_app/features/campaigns/data/models/campaign_model.dart';

abstract class CampaignLocalDataSource {
  Future<List<CampaignModel>> getCampaigns();
  Future<void> joinCampaign(String campaignId);
}

class CampaignLocalDataSourceImpl implements CampaignLocalDataSource {
  // Mock data for campaigns
  final List<CampaignModel> _campaigns = [
    const CampaignModel(
      id: '1',
      title: 'Coffee Lover\'s Reward',
      description: 'Get 20% off your next coffee purchase',
      imageUrl: 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=400',
      pointsReward: 50,
    ),
    const CampaignModel(
      id: '2',
      title: 'Fitness Challenge',
      description: 'Complete 30 days of workouts for amazing rewards',
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400',
      pointsReward: 200,
    ),
    const CampaignModel(
      id: '3',
      title: 'Food Delivery Bonus',
      description: 'Order 5 meals and get free delivery for a month',
      imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
      pointsReward: 100,
    ),
    const CampaignModel(
      id: '4',
      title: 'Shopping Spree',
      description: 'Spend \$100 and get \$20 cashback',
      imageUrl: 'https://images.unsplash.com/photo-1472851294608-062f824d29cc?w=400',
      pointsReward: 150,
    ),
    const CampaignModel(
      id: '5',
      title: 'Book Club Benefits',
      description: 'Read 3 books and unlock exclusive content',
      imageUrl: 'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400',
      pointsReward: 75,
    ),
    const CampaignModel(
      id: '6',
      title: 'Travel Points',
      description: 'Book your next trip and earn double points',
      imageUrl: 'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=400',
      pointsReward: 300,
    ),
  ];

  @override
  Future<List<CampaignModel>> getCampaigns() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _campaigns;
  }

  @override
  Future<void> joinCampaign(String campaignId) async {
    // Simulate joining campaign
    await Future.delayed(const Duration(milliseconds: 300));
    // In real implementation, this would update the backend
  }
}
