import '../../../../core/errors/result.dart';
import '../entities/member.dart';
import '../repositories/membership_repository.dart';

class JoinMembership {
  final MembershipRepository repo;

  JoinMembership(this.repo);

  Future<Result<Member>> call(String name) => repo.joinMembership(name: name);
}
