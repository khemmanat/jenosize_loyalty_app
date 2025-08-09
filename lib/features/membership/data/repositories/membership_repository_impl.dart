import 'package:jenosize_loyalty_app/features/membership/data/datasources/local/datasources/membership_local_data_source.dart';
import 'package:jenosize_loyalty_app/features/membership/domain/entities/member.dart';
import 'package:jenosize_loyalty_app/features/membership/domain/repositories/membership_repository.dart';

class MembershipRepositoryImpl implements MembershipRepository {
  final MembershipLocalDataSource localDataSource;

  MembershipRepositoryImpl({required this.localDataSource});

  @override
  Future<Member?> getMembershipStatus() async {
    print('Fetching membership status from local data source...');
    final memberModel = await localDataSource.getMembershipStatus();
    // check of data type in member Model is MemberModel
    print('MemberModel type: ${memberModel.toString()}');
    return memberModel?.toEntity();
  }

  @override
  Future<void> joinMembership(String name) async {
    return await localDataSource.joinMembership(name);
  }
}