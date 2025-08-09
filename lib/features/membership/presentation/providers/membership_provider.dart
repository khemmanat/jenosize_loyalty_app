import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/injection_container.dart' as di show sl;
import '../../domain/entities/member.dart';
import '../../domain/usecases/get_membership_status.dart';
import '../../domain/usecases/join_membership.dart';

class MembershipState {
  final Member? member;
  final bool isLoading;
  final String? error;

  const MembershipState({
    this.member,
    this.isLoading = false,
    this.error,
  });

  MembershipState copyWith({
    Member? member,
    bool? isLoading,
    String? error,
  }) {
    return MembershipState(
      member: member ?? this.member,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  bool get isMember => member != null;
}

class MembershipNotifier extends StateNotifier<MembershipState> {
  final GetMembershipStatus _getMembershipStatus;
  final JoinMembership _joinMembership;

  MembershipNotifier(this._getMembershipStatus, this._joinMembership)
      : super(const MembershipState()) {
    checkMembershipStatus();
  }

  Future<void> checkMembershipStatus() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      print('Checking membership status...');
      final member = await _getMembershipStatus();
      print('Membership status fetched: $member');
      state = state.copyWith(
        member: member,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> joinMembership(String name) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _joinMembership(name);
      await checkMembershipStatus();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final membershipProvider = StateNotifierProvider<MembershipNotifier, MembershipState>((ref) {
  return MembershipNotifier(
    di.sl<GetMembershipStatus>(),
    di.sl<JoinMembership>(),
  );
});