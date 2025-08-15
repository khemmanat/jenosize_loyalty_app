import '../../../../core/errors/result.dart';
import '../repositories/campaign_repository.dart';

class GetJoinedCampaignIds {
  final CampaignsRepository repo;

  GetJoinedCampaignIds(this.repo);

  Future<Result<Set<String>>> call() => repo.joinedCampaignIds();
}
