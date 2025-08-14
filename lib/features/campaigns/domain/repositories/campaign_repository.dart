import '../../../../core/errors/result.dart';
import '../entities/campaign.dart';

abstract class CampaignsRepository {
  Future<Result<List<Campaign>>> listCampaigns({int page = 1, int limit = 20});
  Future<Result<void>> joinCampaign(String campaignId); // server จะจัดการแต้ม
}