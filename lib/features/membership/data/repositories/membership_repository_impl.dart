import 'package:jenosize_loyalty_app/features/membership/data/datasources/local/datasources/membership_local_data_source.dart';
import 'package:jenosize_loyalty_app/features/membership/domain/entities/member.dart';
import 'package:jenosize_loyalty_app/features/membership/domain/repositories/membership_repository.dart';

import '../../../../core/errors/result.dart';
import '../datasources/local/datasources/membership_remote_data_source.dart';

class MembershipRepositoryImpl implements MembershipRepository {
  final MembershipRemoteDataSource remote;
  final MembershipLocalDataSource local;

  MembershipRepositoryImpl(this.remote, this.local);

  @override
  Future<Result<Member>> getMember() async {
    final r = await remote.getMe();
    return r.fold(
      onSuccess: (dto) async { final m = dto.toDomain(); await local.cacheMember(m); return Ok(m); },
      onFailure: (f) async {
        final cached = await local.getCachedMember();
        return cached.fold(onSuccess: (m) => m != null ? Ok(m) : Err(f), onFailure: (_) => Err(f));
      },
    );
  }

  @override
  Future<Result<Member>> joinMembership({required String name}) async {
    final r = await remote.join(name: name);
    return r.fold(
      onSuccess: (dto) async { final m = dto.toDomain(); await local.cacheMember(m); return Ok(m); },
      onFailure: (f) => Err(f),
    );
  }
}