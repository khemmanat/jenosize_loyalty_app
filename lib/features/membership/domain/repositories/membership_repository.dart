import 'package:jenosize_loyalty_app/features/membership/domain/entities/member.dart';

abstract class MembershipRepository {
  Future<Member?> getMembershipStatus();
  Future<void> joinMembership(String name);
}