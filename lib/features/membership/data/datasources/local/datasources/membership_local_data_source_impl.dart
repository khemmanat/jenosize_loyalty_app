import 'dart:convert';

import 'package:jenosize_loyalty_app/shared/domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/errors/result.dart';
import '../../../../domain/entities/member.dart';
import 'membership_local_data_source.dart';

class MembershipLocalDataSourceImpl implements MembershipLocalDataSource {
  final SharedPreferences prefs;

  MembershipLocalDataSourceImpl(this.prefs);

  static const _k = 'membership.me';

  @override
  Future<Result<void>> cacheMember(Member m) async {
    await prefs.setString(
        _k,
        jsonEncode({
          'id': m.id,
          'name': m.name,
          'joinDate': m.joinDate.toIso8601String(),
          'isActive': m.isActive,
          'tier': m.tier.name,
        }));
    return const Ok(null);
  }

  @override
  Future<Result<Member?>> getCachedMember() async {
    final raw = prefs.getString(_k);
    if (raw == null) return const Ok(null);
    final j = jsonDecode(raw) as Map<String, dynamic>;
    return Ok(Member(
      id: j['id'],
      name: j['name'],
      joinDate: DateTime.parse(j['joinDate']).toUtc(),
      isActive: j['isActive'],
      tier: MemberTier.values.firstWhere((e) => e.name == j['tier'], orElse: () => MemberTier.basic),
    ));
  }
}
