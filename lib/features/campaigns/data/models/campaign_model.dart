import 'package:jenosize_loyalty_app/features/campaigns/domain/entities/campaign.dart';

class CampaignModel extends Campaign {
  const CampaignModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.pointsReward,
    super.isJoined,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      pointsReward: json['pointsReward'] as int,
      isJoined: json['isJoined'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'pointsReward': pointsReward,
      'isJoined': isJoined,
    };
  }
}