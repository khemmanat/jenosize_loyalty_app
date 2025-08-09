import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../di/injection_container.dart' as di;
import '../domain/usecases/generate_referral_code.dart';
import '../domain/usecases/share_referral.dart';

class ReferralState {
  final String? code;
  final bool isLoading;
  final String? error;
  final bool isShared;

  ReferralState({
    this.code,
    this.isLoading = false,
    this.error,
    this.isShared = false,
  });

  ReferralState copyWith({
    String? code,
    bool? isLoading,
    String? error,
    bool? isShared,
  }) {
    return ReferralState(
      code: code ?? this.code,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isShared: isShared ?? this.isShared,
    );
  }
}

class ReferralNotifier extends StateNotifier<ReferralState> {
  final GenerateReferralCode _generateReferralCode;
  final ShareReferral _shareReferral;

  ReferralNotifier(this._generateReferralCode, this._shareReferral) : super(ReferralState()) {
    generateCode();
  }

  Future<void> generateCode() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final code = await _generateReferralCode();
      state = state.copyWith(
        code: code,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> shareCode() async {
    if (state.code == null) return;

    try {
      await _shareReferral(state.code!);
      state = state.copyWith(isShared: true);

      // Reset shared status after delay
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          state = state.copyWith(isShared: false);
        }
      });
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

final referralProvider = StateNotifierProvider<ReferralNotifier, ReferralState>((ref) {
  return ReferralNotifier(
    di.sl<GenerateReferralCode>(),
    di.sl<ShareReferral>(),
  );
});
