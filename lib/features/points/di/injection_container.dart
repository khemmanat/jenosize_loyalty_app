import 'package:get_it/get_it.dart';
import 'package:jenosize_loyalty_app/features/points/data/datasources/local/datasources/points_local_data_source.dart';

import '../data/repositories/points_repository_impl.dart';
import '../domain/repositories/points_repository.dart';
import '../domain/usecases/get_points_balance.dart';
import '../domain/usecases/get_transaction_history.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Data sources
  sl.registerLazySingleton<PointsLocalDataSource>(
      () => PointsLocalDataSourceImpl(sharedPreferences: sl())
  );

  // Repositories
  sl.registerLazySingleton<PointsRepository>(
      () => PointsRepositoryImpl(localDataSource: sl())
  );

  // Use cases
  sl.registerLazySingleton(() => GetPointsBalance(sl()));
  sl.registerLazySingleton(() => GetTransactionHistory(sl()));
}