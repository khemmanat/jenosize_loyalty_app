import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/campaign.dart';

part 'campaign_dto.g.dart';

@JsonSerializable()
class CampaignDto {
  final String id, title, description, imageUrl, ctaText;
  final String? ctaUrl;
  final int rewardPoints;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? startsAt, endsAt;

  final bool isJoined;
  final DateTime? joinedAt;

  CampaignDto({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.ctaText,
    this.ctaUrl,
    required this.rewardPoints,
    required this.isActive,
    required this.createdAt,
    this.startsAt,
    this.endsAt,
    this.isJoined = false,
    this.joinedAt,
  });

  factory CampaignDto.fromJson(Map<String, dynamic> json) => _$CampaignDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignDtoToJson(this);

  Campaign toDomain() => Campaign(
        id: id,
        title: title,
        description: description,
        imageUrl: imageUrl,
        ctaText: ctaText,
        ctaUrl: ctaUrl,
        rewardPoints: rewardPoints,
        isActive: isActive,
        createdAt: createdAt.toUtc(),
        startsAt: startsAt?.toUtc(),
        endsAt: endsAt?.toUtc(),
        isJoined: isJoined,
        joinedAt: joinedAt?.toUtc(),
      );
}
