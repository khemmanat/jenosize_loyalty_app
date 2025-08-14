import 'package:json_annotation/json_annotation.dart';
import '../../../../shared/domain/value_objects.dart';
import '../../domain/entities/point_transaction.dart';

part 'point_transaction_dto.g.dart';

@JsonSerializable()
class PointTransactionDto {
  final String id;
  final String userId;
  final int points;
  final String type;
  final String description;
  final String? referenceId;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  PointTransactionDto({
    required this.id,
    required this.userId,
    required this.points,
    required this.type,
    required this.description,
    this.referenceId,
    required this.createdAt,
  });

  factory PointTransactionDto.fromJson(Map<String, dynamic> json) => _$PointTransactionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PointTransactionDtoToJson(this);

  PointTransaction toDomain() => PointTransaction(
    id: id,
    userId: userId,
    points: points,
    type: pointTypeFromString(type),
    description: description,
    referenceId: referenceId,
    createdAt: createdAt.toUtc(),
  );
}