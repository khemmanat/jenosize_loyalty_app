import 'package:equatable/equatable.dart';

import '../../../../shared/domain/value_objects.dart';

class Referral extends Equatable {
  final String code;
  final String referrerId;
  final String? referredUserId;
  final int pointsAwarded;
  final ReferralStatus status;
  final DateTime createdAt;

  const Referral({
    required this.code,
    required this.referrerId,
    this.referredUserId,
    required this.pointsAwarded,
    required this.status,
    required this.createdAt,
  });

  Referral copyWith({
    String? code,
    String? referrerId,
    String? referredUserId,
    int? pointsAwarded,
    ReferralStatus? status,
    DateTime? createdAt,
  }) =>
      Referral(
        code: code ?? this.code,
        referrerId: referrerId ?? this.referrerId,
        referredUserId: referredUserId ?? this.referredUserId,
        pointsAwarded: pointsAwarded ?? this.pointsAwarded,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  List<Object?> get props => [code, referrerId, referredUserId, pointsAwarded, status, createdAt];
}
