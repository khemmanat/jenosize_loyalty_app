enum PointTransactionType { earn, spend, redeem, adjust, referral, campaignJoin, unknown }

PointTransactionType pointTypeFromString(String s) {
  switch (s.toLowerCase()) {
    case 'earn': return PointTransactionType.earn;
    case 'spend': return PointTransactionType.spend;
    case 'redeem': return PointTransactionType.redeem;
    case 'adjust': return PointTransactionType.adjust;
    case 'referral': return PointTransactionType.referral;
    case 'campaign_join': return PointTransactionType.campaignJoin;
    default: return PointTransactionType.unknown;
  }
}

enum MemberTier { basic, silver, gold, platinum }
enum ReferralStatus { pending, completed, expired }
