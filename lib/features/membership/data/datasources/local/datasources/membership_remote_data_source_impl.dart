import 'package:dio/dio.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/errors/result.dart';
import '../../../models/member_dto.dart';
import 'membership_remote_data_source.dart';

class MembershipRemoteDataSourceImpl implements MembershipRemoteDataSource {
  final Dio dio;

  MembershipRemoteDataSourceImpl(this.dio);

  @override
  Future<Result<MemberDto>> getMe() async {
    try {
      final response = await dio.get('/api/membership/me');

      // Handle successful response
      if (response.data != null) {
        return Ok(MemberDto.fromJson(response.data['data']));
      } else {
        return const Err(UnexpectedFailure('Empty response from server'));
      }
    } catch (error) {
      return Err(ApiErrorHandler.handleDioError(error));
    }
  }

  @override
  Future<Result<MemberDto>> join({required String name}) async {
    try {
      final response = await dio.post(
        '/api/membership/join',
        data: {'name': name},
      );

      if (response.data != null) {
        return Ok(MemberDto.fromJson(response.data));
      } else {
        return const Err(UnexpectedFailure('Empty response from server'));
      }
    } catch (error) {
      return Err(ApiErrorHandler.handleDioError(error));
    }
  }
}
