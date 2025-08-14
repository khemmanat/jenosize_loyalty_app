import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import '../../../core/storage/shared_prefs_provider.dart';
import '../data/datasources/referral_local_data_source_impl.dart';
import '../data/datasources/referral_remote_data_source_impl.dart';
import '../data/repositories/referral_repository_impl.dart';
import '../domain/repositories/referral_repository.dart';
import '../domain/usecases/apply_referral_code.dart';
import '../domain/usecases/get_my_referral_code.dart';
import '../domain/usecases/get_referral_history.dart';

final referralRemoteDataSourceProvider = Provider((ref) => ReferralRemoteDataSourceImpl(ref.watch(dioProvider)));
final referralLocalDataSourceProvider  = Provider((ref) => ReferralLocalDataSourceImpl(ref.watch(sharedPreferencesProvider)));
final referralRepositoryProvider       = Provider<ReferralRepository>((ref) => ReferralRepositoryImpl(
  ref.watch(referralRemoteDataSourceProvider),
  ref.watch(referralLocalDataSourceProvider),
));

final getMyReferralCodeProvider = Provider((ref) => GetMyReferralCode(ref.watch(referralRepositoryProvider)));
final applyReferralCodeProvider = Provider((ref) => ApplyReferralCode(ref.watch(referralRepositoryProvider)));
final getReferralHistoryProvider = Provider((ref) => GetReferralHistory(ref.watch(referralRepositoryProvider)));
