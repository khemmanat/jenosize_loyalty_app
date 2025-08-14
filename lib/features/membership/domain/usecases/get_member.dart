import '../../../../core/errors/result.dart';
import '../entities/member.dart';
import '../repositories/membership_repository.dart';

class GetMember {
  final MembershipRepository repo;

  GetMember(this.repo);

  Future<Result<Member>> call() => repo.getMember();
}
