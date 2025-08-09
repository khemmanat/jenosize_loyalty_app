import 'package:get_it/get_it.dart';
import 'package:jenosize_loyalty_app/features/membership/data/datasources/local/datasources/membership_local_data_source.dart';

import 'package:jenosize_loyalty_app/features/membership/data/repositories/membership_repository_impl.dart';
import 'package:jenosize_loyalty_app/features/membership/domain/repositories/membership_repository.dart';
import 'package:jenosize_loyalty_app/features/membership/domain/usecases/get_membership_status.dart';
import 'package:jenosize_loyalty_app/features/membership/domain/usecases/join_membership.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Data sources
  sl.registerLazySingleton<MembershipLocalDataSource>(
    () => MembershipLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Repositories
  sl.registerLazySingleton<MembershipRepository>(
    () => MembershipRepositoryImpl(localDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetMembershipStatus(sl()));
  sl.registerLazySingleton(() => JoinMembership(sl()));
}
