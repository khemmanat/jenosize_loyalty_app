// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberDto _$MemberDtoFromJson(Map<String, dynamic> json) => MemberDto(
      id: json['id'] as String,
      name: json['name'] as String,
      tier: json['tier'] as String,
      isActive: json['isActive'] as bool,
      joinDate: DateTime.parse(json['joinDate'] as String),
    );

Map<String, dynamic> _$MemberDtoToJson(MemberDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tier': instance.tier,
      'isActive': instance.isActive,
      'joinDate': instance.joinDate.toIso8601String(),
    };
