import 'package:equatable/equatable.dart';

class Campaign extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String ctaText;
  final String? ctaUrl;
  final int rewardPoints;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? startsAt;
  final DateTime? endsAt;

  const Campaign({
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
  });

  Campaign copyWith(
          {String? id,
          String? title,
          String? description,
          String? imageUrl,
          String? ctaText,
          String? ctaUrl,
          int? rewardPoints,
          bool? isActive,
          DateTime? createdAt,
          DateTime? startsAt,
          DateTime? endsAt}) =>
      Campaign(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        ctaText: ctaText ?? this.ctaText,
        ctaUrl: ctaUrl ?? this.ctaUrl,
        rewardPoints: rewardPoints ?? this.rewardPoints,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        startsAt: startsAt ?? this.startsAt,
        endsAt: endsAt ?? this.endsAt,
      );

  @override
  List<Object?> get props => [id, title, description, imageUrl, ctaText, ctaUrl, rewardPoints, isActive, createdAt, startsAt, endsAt];
}
