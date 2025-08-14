import '../../../../../../core/errors/result.dart';
import '../../../models/member_dto.dart';

abstract class MembershipRemoteDataSource {
  Future<Result<MemberDto>> getMe();
  Future<Result<MemberDto>> join({required String name});
}