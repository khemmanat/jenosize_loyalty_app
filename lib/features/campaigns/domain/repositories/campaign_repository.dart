import 'package:jenosize_loyalty_app/features/campaigns/domain/entities/campaign.dart';

abstract class CampaignRepository {
  Future<List<Campaign>> getCampaigns();
  Future<void> joinCampaign(String campaignId);
}