import '../../domain/repositories/referral_repository.dart';
import '../datasources/referral_local_data_source.dart';

class ReferralRepositoryImpl implements ReferralRepository {
  final ReferralLocalDataSource localDataSource;

  ReferralRepositoryImpl({required this.localDataSource});

  @override
  Future<String> generateReferralCode() async {
    return await localDataSource.generateReferralCode();
  }

  @override
  Future<void> shareReferral(String code) async {
    return await localDataSource.shareReferral(code);
  }
}