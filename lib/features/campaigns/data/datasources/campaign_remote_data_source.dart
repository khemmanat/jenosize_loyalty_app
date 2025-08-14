import '../../../../core/errors/result.dart';
import '../models/campaign_dto.dart';

abstract class CampaignsRemoteDataSource {
  Future<Result<List<CampaignDto>>> list({required int page, required int limit});
  Future<Result<void>> join(String campaignId);
}