import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/referral_di.dart';
import '../../domain/entities/referral.dart';

final myCodeProvider = FutureProvider.autoDispose<String>((ref) async {
  final usecase = ref.read(getMyReferralCodeProvider);
  final r = await usecase();
  return r.fold(onSuccess: (c) => c, onFailure: (f) => throw Exception(f.message));
});

final historyPage1Provider = FutureProvider.autoDispose<List<Referral>>((ref) async {
  final usecase = ref.read(getReferralHistoryProvider);
  final r = await usecase(page: 1, limit: 20);
  return r.fold(onSuccess: (list) => list, onFailure: (f) => throw Exception(f.message));
});
