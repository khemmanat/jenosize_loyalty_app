// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignDto _$CampaignDtoFromJson(Map<String, dynamic> json) => CampaignDto(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      ctaText: json['ctaText'] as String,
      ctaUrl: json['ctaUrl'] as String?,
      rewardPoints: (json['rewardPoints'] as num).toInt(),
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      startsAt: json['startsAt'] == null
          ? null
          : DateTime.parse(json['startsAt'] as String),
      endsAt: json['endsAt'] == null
          ? null
          : DateTime.parse(json['endsAt'] as String),
    );

Map<String, dynamic> _$CampaignDtoToJson(CampaignDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'ctaText': instance.ctaText,
      'ctaUrl': instance.ctaUrl,
      'rewardPoints': instance.rewardPoints,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'startsAt': instance.startsAt?.toIso8601String(),
      'endsAt': instance.endsAt?.toIso8601String(),
    };
