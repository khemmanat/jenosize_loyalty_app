class CampaignJoinData {
  final String campaignId;
  final String title;
  final int rewardPoints;
  final DateTime joinedAt;

  const CampaignJoinData({
    required this.campaignId,
    required this.title,
    required this.rewardPoints,
    required this.joinedAt,
  });

  factory CampaignJoinData.fromJson(Map<String, dynamic> json) {
    return CampaignJoinData(
      campaignId: json['campaignId'] as String,
      title: json['title'] as String,
      rewardPoints: json['rewardPoints'] as int,
      joinedAt: DateTime.parse(json['joinedAt'] as String),
    );
  }
}
