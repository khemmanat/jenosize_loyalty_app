import 'package:json_annotation/json_annotation.dart';

part 'points_summary_dto.g.dart';

@JsonSerializable()
class PointsSummaryDto {
  final int totalPoints;
  final int earnedThisMonth;
  final int redeemedThisMonth;

  PointsSummaryDto({required this.totalPoints, required this.earnedThisMonth, required this.redeemedThisMonth});

  factory PointsSummaryDto.fromJson(Map<String, dynamic> json) => _$PointsSummaryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PointsSummaryDtoToJson(this);
}