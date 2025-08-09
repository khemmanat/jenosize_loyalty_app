import 'package:jenosize_loyalty_app/features/campaigns/domain/repositories/campaign_repository.dart';

class JoinCampaign {
  final CampaignRepository repository;

  JoinCampaign(this.repository);

  Future<void> call(String campaignId) async {
    await repository.joinCampaign(campaignId);
  }
}