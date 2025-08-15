import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/campaigns_di.dart';
import '../../domain/entities/campaign.dart';

class CampaignCardVM {
  final Campaign campaign;
  final bool joined;
  CampaignCardVM({required this.campaign, required this.joined});
}

final campaignsVMProvider = FutureProvider.autoDispose<List<CampaignCardVM>>((ref) async {
  final list = ref.read(listCampaignsProvider);
  final joinedIdsUsecase = ref.read(getJoinedCampaignIdsProvider);

  final r1 = await list(page: 1, limit: 20);
  final r2 = await joinedIdsUsecase();

  return r1.fold(
    onSuccess: (items) => r2.fold(
      onSuccess: (ids) {
        final set = ids;
        return items.map((c) => CampaignCardVM(campaign: c, joined: set.contains(c.id))).toList();
      },
      onFailure: (_) => items.map((c) => CampaignCardVM(campaign: c, joined: false)).toList(),
    ),
    onFailure: (f) => throw Exception('We couldn’t load campaigns. Pull to refresh.'),
  );
});