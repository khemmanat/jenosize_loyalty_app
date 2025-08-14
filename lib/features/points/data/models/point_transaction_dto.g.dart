// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_transaction_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointTransactionDto _$PointTransactionDtoFromJson(Map<String, dynamic> json) =>
    PointTransactionDto(
      id: json['id'] as String,
      userId: json['userId'] as String,
      points: (json['points'] as num).toInt(),
      type: json['type'] as String,
      description: json['description'] as String,
      referenceId: json['referenceId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PointTransactionDtoToJson(
        PointTransactionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'points': instance.points,
      'type': instance.type,
      'description': instance.description,
      'referenceId': instance.referenceId,
      'createdAt': instance.createdAt.toIso8601String(),
    };
