import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import '../../../core/storage/shared_prefs_provider.dart';
import '../data/datasources/points_local_data_source.dart';
import '../data/datasources/points_local_data_source_impl.dart';
import '../data/datasources/points_remote_data_source.dart';
import '../data/datasources/points_remote_data_source_impl.dart';
import '../data/repositories/points_repository_impl.dart';
import '../domain/repositories/points_repository.dart';
import '../domain/usecases/get_point_transactions.dart';
import '../domain/usecases/get_points_balance.dart';
import '../domain/usecases/get_points_summary.dart';
import '../domain/usecases/redeem_points.dart';

final pointsRemoteDataSourceProvider = Provider<PointsRemoteDataSource>((ref) => PointsRemoteDataSourceImpl(ref.watch(dioProvider)));
final pointsLocalDataSourceProvider = Provider<PointsLocalDataSource>((ref) => PointsLocalDataSourceImpl(ref.watch(sharedPreferencesProvider)));
final pointsRepositoryProvider = Provider<PointsRepository>((ref) => PointsRepositoryImpl(ref.watch(pointsRemoteDataSourceProvider), ref.watch(pointsLocalDataSourceProvider)));

final getPointsBalanceProvider = Provider((ref) => GetPointsBalance(ref.watch(pointsRepositoryProvider)));
final getPointTransactionsProvider = Provider((ref) => GetPointTransactions(ref.watch(pointsRepositoryProvider)));
final getPointsSummaryProvider = Provider((ref) => GetPointsSummary(ref.watch(pointsRepositoryProvider)));
final redeemPointsProvider = Provider((ref) => RedeemPoints(ref.watch(pointsRepositoryProvider)));
