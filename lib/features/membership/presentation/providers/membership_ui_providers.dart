import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/membership_di.dart';
import '../../domain/entities/member.dart';

final memberProvider = FutureProvider.autoDispose<Member?>((ref) async {
  final get = ref.read(getMemberProvider);
  final r = await get();
  return r.fold(onSuccess: (m) => m, onFailure: (f) => throw Exception(f.message));
});
