import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/errors/result.dart';
import '../models/referral_dto.dart';
import 'referral_remote_data_source.dart';

class ReferralRemoteDataSourceImpl implements ReferralRemoteDataSource {
  final Dio dio;

  ReferralRemoteDataSourceImpl(this.dio);

  @override
  Future<Result<String>> getMyCode() async {
    try {
      final r = await dio.get('/api/referral/code');
      return Ok(r.data['code'] as String);
    } on DioException catch (e) {
      return Err(NetworkFailure(e.message ?? 'Network error', code: e.response?.statusCode));
    } catch (_) {
      return const Err(UnexpectedFailure('Unexpected error'));
    }
  }

  @override
  Future<Result<void>> apply(String code) async {
    try {
      await dio.post('/api/referral/apply', data: {'code': code});
      return const Ok(null);
    } on DioException catch (e) {
      return Err(NetworkFailure(e.message ?? 'Network error', code: e.response?.statusCode));
    } catch (_) {
      return const Err(UnexpectedFailure('Unexpected error'));
    }
  }

  @override
  Future<Result<List<ReferralDto>>> history({required int page, required int limit}) async {
    try {
      final r = await dio.get('/api/referral/history', queryParameters: {'page': page, 'limit': limit});
      final items = (r.data['items'] as List).map((e) => ReferralDto.fromJson(e)).toList();
      return Ok(items);
    } on DioException catch (e) {
      return Err(NetworkFailure(e.message ?? 'Network error', code: e.response?.statusCode));
    } catch (_) {
      return const Err(UnexpectedFailure('Unexpected error'));
    }
  }
}
