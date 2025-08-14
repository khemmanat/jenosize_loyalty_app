import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import '../../../core/storage/shared_prefs_provider.dart';
import '../data/datasources/campaign_local_data_source_impl.dart';
import '../data/datasources/campaign_remote_data_source_impl.dart';
import '../data/repositories/campaign_repository_impl.dart';
import '../domain/repositories/campaign_repository.dart';
import '../domain/usecases/join_campaign.dart';
import '../domain/usecases/list_campaigns.dart';

final campaignsRemoteDataSourceProvider = Provider((ref) => CampaignsRemoteDataSourceImpl(ref.watch(dioProvider)));
final campaignsLocalDataSourceProvider = Provider((ref) => CampaignsLocalDataSourceImpl(ref.watch(sharedPreferencesProvider)));
final campaignsRepositoryProvider = Provider<CampaignsRepository>((ref) => CampaignsRepositoryImpl(
      ref.watch(campaignsRemoteDataSourceProvider),
      ref.watch(campaignsLocalDataSourceProvider),
    ));

final listCampaignsProvider = Provider((ref) => ListCampaigns(ref.watch(campaignsRepositoryProvider)));
final joinCampaignProvider = Provider((ref) => JoinCampaign(ref.watch(campaignsRepositoryProvider)));
