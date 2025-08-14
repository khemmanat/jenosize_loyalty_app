import 'package:json_annotation/json_annotation.dart';

import '../../../../shared/domain/value_objects.dart';
import '../../domain/entities/referral.dart';

part 'referral_dto.g.dart';

ReferralStatus _statusFrom(String s) {
  switch (s.toLowerCase()) {
    case 'pending':
      return ReferralStatus.pending;
    case 'completed':
      return ReferralStatus.completed;
    case 'expired':
      return ReferralStatus.expired;
    default:
      return ReferralStatus.pending;
  }
}

@JsonSerializable()
class ReferralDto {
  final String code, referrerId;
  final String? referredUserId;
  final int pointsAwarded;
  final String status;
  final DateTime createdAt;

  ReferralDto({required this.code, required this.referrerId, this.referredUserId, required this.pointsAwarded, required this.status, required this.createdAt});

  factory ReferralDto.fromJson(Map<String, dynamic> j) => _$ReferralDtoFromJson(j);

  Map<String, dynamic> toJson() => _$ReferralDtoToJson(this);

  Referral toDomain() => Referral(code: code, referrerId: referrerId, referredUserId: referredUserId, pointsAwarded: pointsAwarded, status: _statusFrom(status), createdAt: createdAt.toUtc());
}
