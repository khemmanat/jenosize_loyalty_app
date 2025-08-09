import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/injection_container.dart' as di;
import '../../domain/entities/campaign.dart';
import '../../domain/usecases/get_campaigns.dart';
import '../../domain/usecases/join_campaign.dart';

class CampaignState {
  final List<Campaign> campaigns;
  final bool isLoading;
  final String? error;

  const CampaignState({
    this.campaigns = const [],
    this.isLoading = false,
    this.error,
  });

  CampaignState copyWith({
    List<Campaign>? campaigns,
    bool? isLoading,
    String? error,
  }) {
    return CampaignState(
      campaigns: campaigns ?? this.campaigns,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Simple StateNotifier without code generation
class CampaignNotifier extends StateNotifier<CampaignState> {
  final GetCampaigns _getCampaigns;
  final JoinCampaign _joinCampaign;

  CampaignNotifier(this._getCampaigns, this._joinCampaign)
      : super(const CampaignState()) {
    loadCampaigns();
  }

  Future<void> loadCampaigns() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final campaigns = await _getCampaigns();
      state = state.copyWith(
        campaigns: campaigns,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> joinCampaign(String campaignId) async {
    try {
      await _joinCampaign(campaignId);

      // Update local state immediately
      final updatedCampaigns = state.campaigns.map((campaign) {
        if (campaign.id == campaignId) {
          return campaign.copyWith(isJoined: true);
        }
        return campaign;
      }).toList();

      state = state.copyWith(campaigns: updatedCampaigns);

      // Reload from server
      await loadCampaigns();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

// Provider
final campaignProvider = StateNotifierProvider<CampaignNotifier, CampaignState>((ref) {
  return CampaignNotifier(
    di.sl<GetCampaigns>(),
    di.sl<JoinCampaign>(),
  );
});