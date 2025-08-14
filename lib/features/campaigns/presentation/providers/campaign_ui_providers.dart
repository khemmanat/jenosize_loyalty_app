import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/campaigns_di.dart';
import '../../domain/entities/campaign.dart';

final campaignsPage1Provider = FutureProvider.autoDispose<List<Campaign>>((ref) async {
  final list = ref.read(listCampaignsProvider);
  final r = await list(page: 1, limit: 20);
  return r.fold(onSuccess: (it) => it, onFailure: (f) => throw Exception(f.message));
});
