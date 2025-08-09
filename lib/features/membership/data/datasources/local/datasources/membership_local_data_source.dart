import 'dart:convert';

import 'package:jenosize_loyalty_app/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/member_model.dart';

abstract class MembershipLocalDataSource {
  Future<MemberModel?> getMembershipStatus();
  Future<void> joinMembership(String name);
}

class MembershipLocalDataSourceImpl implements MembershipLocalDataSource {
  final SharedPreferences sharedPreferences;

  MembershipLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<MemberModel?> getMembershipStatus() async {
    print('Fetching membership status from local data source...');
    final memberJson = sharedPreferences.getString(AppConstants.membershipStatusKey);
    if (memberJson != null) {
      print('Membership status found in local data source.');
      try {
        final decodedJson = json.decode(memberJson);
        final res = MemberModel.fromJson(decodedJson);
        print('Parsed MemberModel: ${res.toString()}');
        return res;
      } catch (e) {
        print('Error parsing membership data: $e');
        return null;
      }
    }
    print('No membership status found in local data source.');
    return null;
  }

  @override
  Future<void> joinMembership(String name) async {
    final member = MemberModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      joinDate: DateTime.now(),
    );

    await sharedPreferences.setString(
      AppConstants.membershipStatusKey,
      json.encode(member.toJson()),
    );
  }
}