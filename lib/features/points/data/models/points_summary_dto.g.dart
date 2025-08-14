// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_summary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointsSummaryDto _$PointsSummaryDtoFromJson(Map<String, dynamic> json) =>
    PointsSummaryDto(
      totalPoints: (json['totalPoints'] as num).toInt(),
      earnedThisMonth: (json['earnedThisMonth'] as num).toInt(),
      redeemedThisMonth: (json['redeemedThisMonth'] as num).toInt(),
    );

Map<String, dynamic> _$PointsSummaryDtoToJson(PointsSummaryDto instance) =>
    <String, dynamic>{
      'totalPoints': instance.totalPoints,
      'earnedThisMonth': instance.earnedThisMonth,
      'redeemedThisMonth': instance.redeemedThisMonth,
    };
