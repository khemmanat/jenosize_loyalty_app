import 'package:jenosize_loyalty_app/features/points/domain/entities/point_transaction.dart';

import 'campaign_join_data.dart';

class CampaignJoinResult {
  final CampaignJoinData campaign;
  final int pointsEarned;
  final PointTransaction? transaction;
  final bool success;
  final String? warning;

  const CampaignJoinResult({
    required this.campaign,
    required this.pointsEarned,
    this.transaction,
    required this.success,
    this.warning,
  });

  factory CampaignJoinResult.fromJson(Map<String, dynamic> json) {
    return CampaignJoinResult(
      campaign: CampaignJoinData.fromJson(json['campaign']),
      pointsEarned: json['pointsEarned'] as int,
      transaction: json['transaction'] != null
          ? PointTransaction.fromJson(json['transaction'])
          : null,
      success: json['success'] as bool,
      warning: json['warning'] as String?,
    );
  }
}