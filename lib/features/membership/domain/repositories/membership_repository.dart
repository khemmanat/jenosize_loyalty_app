import '../../../../core/errors/result.dart';
import '../entities/member.dart';

abstract class MembershipRepository {
  Future<Result<Member>> getMember();
  Future<Result<Member>> joinMembership({required String name});
}