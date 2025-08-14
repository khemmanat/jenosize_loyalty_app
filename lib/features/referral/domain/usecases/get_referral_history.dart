import '../../../../core/errors/result.dart';
import '../entities/referral.dart';
import '../repositories/referral_repository.dart';

class GetReferralHistory {
  final ReferralRepository repo;

  GetReferralHistory(this.repo);

  Future<Result<List<Referral>>> call({int page = 1, int limit = 20}) => repo.getReferralHistory(page: page, limit: limit);
}
