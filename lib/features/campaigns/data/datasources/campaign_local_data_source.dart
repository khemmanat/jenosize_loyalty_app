import '../../../../core/errors/result.dart';
import '../../domain/entities/campaign.dart';

abstract class CampaignsLocalDataSource {
  Future<Result<void>> cacheList(List<Campaign> items); // แคชหน้าแรก
  Future<Result<List<Campaign>>> getCachedList();
}
