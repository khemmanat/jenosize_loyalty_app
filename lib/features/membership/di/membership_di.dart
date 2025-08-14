import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import '../../../core/storage/shared_prefs_provider.dart';
import '../data/datasources/local/datasources/membership_local_data_source_impl.dart';
import '../data/datasources/local/datasources/membership_remote_data_source_impl.dart';
import '../data/repositories/membership_repository_impl.dart';
import '../domain/repositories/membership_repository.dart';
import '../domain/usecases/get_member.dart';
import '../domain/usecases/join_membership.dart';

final membershipRemoteDataSourceProvider = Provider((ref) => MembershipRemoteDataSourceImpl(ref.watch(dioProvider)));
final membershipLocalDataSourceProvider = Provider((ref) => MembershipLocalDataSourceImpl(ref.watch(sharedPreferencesProvider)));
final membershipRepositoryProvider = Provider<MembershipRepository>((ref) => MembershipRepositoryImpl(
      ref.watch(membershipRemoteDataSourceProvider),
      ref.watch(membershipLocalDataSourceProvider),
    ));

final getMemberProvider = Provider((ref) => GetMember(ref.watch(membershipRepositoryProvider)));
final joinMembershipProvider = Provider((ref) => JoinMembership(ref.watch(membershipRepositoryProvider)));
