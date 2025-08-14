import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/errors/result.dart';
import '../models/campaign_dto.dart';
import 'campaign_remote_data_source.dart';

class CampaignsRemoteDataSourceImpl implements CampaignsRemoteDataSource {
  final Dio dio;
  CampaignsRemoteDataSourceImpl(this.dio);

  @override
  Future<Result<List<CampaignDto>>> list({required int page, required int limit}) async {
    try {
      final r = await dio.get('/api/campaigns', queryParameters: {'page': page, 'limit': limit});
      final items = (r.data['data']['items'] as List).map((e) => CampaignDto.fromJson(e)).toList();
      return Ok(items);
    } on DioException catch (e) {
      return Err(NetworkFailure(e.message ?? 'Network error', code: e.response?.statusCode));
    } catch (_) {
      return const Err(UnexpectedFailure('Unexpected error'));
    }
  }

  @override
  Future<Result<void>> join(String campaignId) async {
    try {
      await dio.post('/api/campaigns/$campaignId/join');
      return const Ok(null);
    } on DioException catch (e) {
      return Err(NetworkFailure(e.message ?? 'Network error', code: e.response?.statusCode));
    } catch (_) {
      return const Err(UnexpectedFailure('Unexpected error'));
    }
  }
}
