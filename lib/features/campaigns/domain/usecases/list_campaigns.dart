import '../../../../core/errors/result.dart';
import '../entities/campaign.dart';
import '../repositories/campaign_repository.dart';

class ListCampaigns {
  final CampaignsRepository repo;

  ListCampaigns(this.repo);

  Future<Result<List<Campaign>>> call({int page = 1, int limit = 20}) => repo.listCampaigns(page: page, limit: limit);
}
