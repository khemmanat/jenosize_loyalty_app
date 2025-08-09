import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/referral/di/injection_container.dart' as referral_di;
import 'features/campaigns/di/injection_container.dart' as campaigns_di;
import 'features/membership//di/injection_container.dart' as membership_di;
import 'features/points/di/injection_container.dart' as points_di;

final sl = GetIt.instance;

Future<void> init() async {
  // Core dependencies
  await _initCore();

  await campaigns_di.init();
  await membership_di.init();
  await referral_di.init();
  await points_di.init();
}

Future<void> _initCore() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}