import '../../../../core/errors/result.dart';
import '../entities/campaign_join_result.dart';
import '../repositories/campaign_repository.dart';

class JoinCampaign {
  final CampaignsRepository repo;

  JoinCampaign(this.repo);

  Future<Result<CampaignJoinResult>> call(String campaignId) => repo.joinCampaign(campaignId);
}