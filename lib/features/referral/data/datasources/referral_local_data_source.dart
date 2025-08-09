import 'package:jenosize_loyalty_app/core/constants/app_constants.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

abstract class ReferralLocalDataSource {
  Future<String> generateReferralCode();
  Future<void> shareReferral(String code);
}

class ReferralLocalDataSourceImpl implements ReferralLocalDataSource {
  final SharedPreferences sharedPreferences;
  final Uuid _uuid = const Uuid();

  ReferralLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<String> generateReferralCode() async {
    // Check if code already exists
    String? existingCode = sharedPreferences.getString(AppConstants.referralCodeKey);

    if (existingCode != null) {
      return existingCode;
    }

    // Generate new code
    final code = '${AppConstants.defaultReferralPrefix}${_uuid.v4().substring(0, 8).toUpperCase()}';
    await sharedPreferences.setString(AppConstants.referralCodeKey, code);

    return code;
  }

  @override
  Future<void> shareReferral(String code) async {
    final shareText = 'Join Jenosize Loyalty and earn rewards! Use my referral code: $code\n\nDownload the app: https://jenosize.com/app';
    ShareParams params = ShareParams(
      text: shareText,
      subject: 'Join Jenosize Loyalty!',
    );
    await SharePlus.instance.share(params);
  }
}