import '../../domain/entities/campaign.dart';
import '../../domain/repositories/campaign_repository.dart';
import '../datasources/local/campaign_local_data_source.dart';

class CampaignRepositoryImpl implements CampaignRepository {
  final CampaignLocalDataSource localDataSource;

  CampaignRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Campaign>> getCampaigns() async {
    return await localDataSource.getCampaigns();
  }

  @override
  Future<void> joinCampaign(String campaignId) async {
    return await localDataSource.joinCampaign(campaignId);
  }
}