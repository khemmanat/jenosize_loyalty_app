import 'package:get_it/get_it.dart';
import 'package:jenosize_loyalty_app/features/referral/data/datasources/referral_local_data_source.dart';
import 'package:jenosize_loyalty_app/features/referral/domain/usecases/generate_referral_code.dart';
import 'package:jenosize_loyalty_app/features/referral/domain/usecases/share_referral.dart';

import '../data/repositories/referral_repository_impl.dart';
import '../domain/repositories/referral_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Data sources
  sl.registerLazySingleton<ReferralLocalDataSource>(
    () => ReferralLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Repositories
  sl.registerLazySingleton<ReferralRepository>(
    () => ReferralRepositoryImpl(localDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GenerateReferralCode(sl()));
  sl.registerLazySingleton(() => ShareReferral(sl()));
}
