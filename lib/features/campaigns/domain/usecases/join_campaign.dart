import '../../../../core/errors/result.dart';
import '../repositories/campaign_repository.dart';

class JoinCampaign {
  final CampaignsRepository repo;

  JoinCampaign(this.repo);

  Future<Result<void>> call(String campaignId) => repo.joinCampaign(campaignId);
}