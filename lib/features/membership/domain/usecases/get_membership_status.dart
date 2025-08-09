import 'package:jenosize_loyalty_app/features/membership/domain/entities/member.dart';
import 'package:jenosize_loyalty_app/features/membership/domain/repositories/membership_repository.dart';

class GetMembershipStatus {
  final MembershipRepository repository;

  GetMembershipStatus(this.repository);

  Future<Member?> call() async {
    print('Getting membership status...');
    return await repository.getMembershipStatus();
  }
}