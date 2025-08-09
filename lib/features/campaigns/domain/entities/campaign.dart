import 'package:equatable/equatable.dart';

class Campaign extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final int pointsReward;
  final bool isJoined;
  final DateTime? startDate;
  final DateTime? endDate;

  const Campaign({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.pointsReward,
    this.isJoined = false,
    this.startDate,
    this.endDate,
  });

  Campaign copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    int? pointsReward,
    bool? isJoined,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Campaign(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      pointsReward: pointsReward ?? this.pointsReward,
      isJoined: isJoined ?? this.isJoined,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    imageUrl,
    pointsReward,
    isJoined,
    startDate,
    endDate,
  ];
}