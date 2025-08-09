import 'package:jenosize_loyalty_app/features/membership/domain/repositories/membership_repository.dart';

class JoinMembership {
  final MembershipRepository repository;

  JoinMembership(this.repository);

  Future<void> call(String name) async {
    await repository.joinMembership(name);
  }
}