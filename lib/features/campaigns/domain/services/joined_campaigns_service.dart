import 'package:jenosize_loyalty_app/core/errors/result.dart';

abstract class JoinedCampaignsService {
  Future<Result<void>> markAsJoined(String campaignId, DateTime joinedAt);
  Future<Result<Set<String>>> getJoinedIds();
  Future<Result<bool>> isJoined(String campaignId);
}
