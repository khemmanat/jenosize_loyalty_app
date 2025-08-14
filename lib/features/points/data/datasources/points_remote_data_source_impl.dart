import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/errors/result.dart';
import '../models/point_transaction_dto.dart';
import '../models/points_summary_dto.dart';
import 'points_remote_data_source.dart';

class PointsRemoteDataSourceImpl implements PointsRemoteDataSource {
  final Dio dio;

  PointsRemoteDataSourceImpl(this.dio);

  @override
  Future<Result<int>> getBalance() async {
    try {
      final r = await dio.get('/points/balance');
      return Ok(r.data['balance'] as int);
    } on DioException catch (e) {
      return Err(NetworkFailure(e.message ?? 'Network error', code: e.response?.statusCode));
    } catch (_) {
      return const Err(UnexpectedFailure('Unexpected error'));
    }
  }

  @override
  Future<Result<List<PointTransactionDto>>> getTransactions({required int page, required int limit}) async {
    try {
      final r = await dio.get('/api/points/transactions', queryParameters: {'page': page, 'limit': limit});
      final items = (r.data['items'] as List).map((j) => PointTransactionDto.fromJson(j)).toList();
      return Ok(items);
    } on DioException catch (e) {
      return Err(NetworkFailure(e.message ?? 'Network error', code: e.response?.statusCode));
    } catch (_) {
      return const Err(UnexpectedFailure('Unexpected error'));
    }
  }

  @override
  Future<Result<PointsSummaryDto>> getSummary() async {
    try {
      final r = await dio.get('/api/points/summary');
      return Ok(PointsSummaryDto.fromJson(r.data));
    } on DioException catch (e) {
      return Err(NetworkFailure(e.message ?? 'Network error', code: e.response?.statusCode));
    } catch (_) {
      return const Err(UnexpectedFailure('Unexpected error'));
    }
  }

  @override
  Future<Result<void>> redeemPoints({required int points, String? description}) async {
    try {
      await dio.post('/api/points/redeem', data: {'points': points, 'description': description});
      return const Ok(null);
    } on DioException catch (e) {
      return Err(NetworkFailure(e.message ?? 'Network error', code: e.response?.statusCode));
    } catch (_) {
      return const Err(UnexpectedFailure('Unexpected error'));
    }
  }
}
