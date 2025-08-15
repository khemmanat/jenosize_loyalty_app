import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/campaign_join_result.dart';
import '../models/campaign_dto.dart';
import 'campaign_remote_data_source.dart';

class CampaignsRemoteDataSourceImpl implements CampaignsRemoteDataSource {
  final Dio dio;
  CampaignsRemoteDataSourceImpl(this.dio);

  @override
  Future<Result<List<CampaignDto>>> list({required int page, required int limit}) async {
    try {
      final response = await dio.get('/api/campaigns',
          queryParameters: {'page': page, 'limit': limit});
      final items = (response.data['data']['items'] as List)
          .map((e) => CampaignDto.fromJson(e))
          .toList();
      return Ok(items);
    } on DioException catch (e) {
      return Err(NetworkFailure(e.message ?? 'Network error',
          code: e.response?.statusCode));
    } catch (_) {
      return const Err(UnexpectedFailure('Unexpected error'));
    }
  }

  @override
  Future<Result<CampaignJoinResult>> join(String campaignId) async {
    try {
      final r = await dio.post('/api/campaigns/$campaignId/join');

      // โหมดแบ็กเอนด์ “ส่งบอดี้” (แนะนำ)
      if (r.data is Map<String, dynamic>) {
        return Ok(CampaignJoinResult.fromJson(r.data as Map<String, dynamic>));
      }

      // โหมดแบ็กเอนด์ตอบ 204 ไม่มีบอดี้ → ให้ repo สังเคราะห์ต่อ
      return Err(NetworkFailure('EMPTY_JOIN_RESPONSE', code: r.statusCode));
    } on DioException catch (e) {
      return Err(NetworkFailure(e.message ?? 'Network error', code: e.response?.statusCode));
    } catch (_) {
      return const Err(UnexpectedFailure('Unexpected error'));
    }
  }
}