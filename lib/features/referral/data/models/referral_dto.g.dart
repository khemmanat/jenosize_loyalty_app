// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referral_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReferralDto _$ReferralDtoFromJson(Map<String, dynamic> json) => ReferralDto(
      code: json['code'] as String,
      referrerId: json['referrerId'] as String,
      referredUserId: json['referredUserId'] as String?,
      pointsAwarded: (json['pointsAwarded'] as num).toInt(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ReferralDtoToJson(ReferralDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'referrerId': instance.referrerId,
      'referredUserId': instance.referredUserId,
      'pointsAwarded': instance.pointsAwarded,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
    };
