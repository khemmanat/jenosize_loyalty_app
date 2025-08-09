import 'package:jenosize_loyalty_app/features/campaigns/domain/entities/campaign.dart';
import 'package:jenosize_loyalty_app/features/campaigns/domain/repositories/campaign_repository.dart';

class GetCampaigns {
  final CampaignRepository repository;

  GetCampaigns(this.repository);

  Future<List<Campaign>> call() async {
    return await repository.getCampaigns();
  }
}