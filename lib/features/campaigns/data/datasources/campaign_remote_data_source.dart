import '../../../../core/errors/result.dart';
import '../../domain/entities/campaign_join_result.dart';
import '../models/campaign_dto.dart';

abstract class CampaignsRemoteDataSource {
  Future<Result<List<CampaignDto>>> list({required int page, required int limit});
  Future<Result<CampaignJoinResult>> join(String campaignId);
}