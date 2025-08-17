import 'package:flutter/material.dart';
import 'package:jenosize_loyalty_app/features/points/data/models/point_transaction_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'points_summary_dto.g.dart';

@JsonSerializable()
class PointsSummaryDto {
  final int totalPoints;
  final int earnedThisMonth;
  final int spentThisMonth;
  final List<PointTransactionDto> recentTransactions;

  PointsSummaryDto({required this.totalPoints, required this.earnedThisMonth, required this.spentThisMonth, required this.recentTransactions});

  factory PointsSummaryDto.fromJson(Map<String, dynamic> json) {
    debugPrint('Parsing PointsSummaryDto from JSON: $json');
    return _$PointsSummaryDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PointsSummaryDtoToJson(this);
}
