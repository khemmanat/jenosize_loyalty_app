import '../../../../core/errors/result.dart';
import '../entities/campaign.dart';
import '../entities/campaign_join_result.dart';

abstract class CampaignsRepository {
  Future<Result<List<Campaign>>> listCampaigns({int page, int limit});
  Future<Result<CampaignJoinResult>> joinCampaign(String campaignId);

  // ใช้บริการโลคัล
  Future<Result<Set<String>>> joinedCampaignIds();
}