// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_summary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointsSummaryDto _$PointsSummaryDtoFromJson(Map<String, dynamic> json) =>
    PointsSummaryDto(
      totalPoints: (json['totalPoints'] as num).toInt(),
      earnedThisMonth: (json['earnedThisMonth'] as num).toInt(),
      spentThisMonth: (json['spentThisMonth'] as num).toInt(),
      recentTransactions: (json['recentTransactions'] as List<dynamic>)
          .map((e) => PointTransactionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PointsSummaryDtoToJson(PointsSummaryDto instance) =>
    <String, dynamic>{
      'totalPoints': instance.totalPoints,
      'earnedThisMonth': instance.earnedThisMonth,
      'spentThisMonth': instance.spentThisMonth,
      'recentTransactions': instance.recentTransactions,
    };
