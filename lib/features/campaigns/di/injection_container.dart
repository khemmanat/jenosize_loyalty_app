import 'package:get_it/get_it.dart';
import 'package:jenosize_loyalty_app/features/campaigns/domain/usecases/join_campaign.dart';

import '../data/datasources/local/campaign_local_data_source.dart';
import '../data/repositories/campaign_repository_impl.dart';
import '../domain/repositories/campaign_repository.dart';
import '../domain/usecases/get_campaigns.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Data sources
  sl.registerLazySingleton<CampaignLocalDataSource>(
    () => CampaignLocalDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<CampaignRepository>(
    () => CampaignRepositoryImpl(localDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCampaigns(sl()));
  sl.registerLazySingleton(() => JoinCampaign(sl()));
}