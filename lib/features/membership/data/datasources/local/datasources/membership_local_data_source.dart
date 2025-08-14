import '../../../../../../core/errors/result.dart';
import '../../../../domain/entities/member.dart';

abstract class MembershipLocalDataSource {
  Future<Result<void>> cacheMember(Member m);
  Future<Result<Member?>> getCachedMember();
}