import 'package:equatable/equatable.dart';

class Referral extends Equatable {
  final String code;
  final String userId;
  final int pointsEarned;
  final DateTime createdAt;

  const Referral({
    required this.code,
    required this.userId,
    required this.pointsEarned,
    required this.createdAt,
  });

  Referral copyWith({
    String? code,
    String? userId,
    int? pointsEarned,
    DateTime? createdAt,
  }) {
    return Referral(
      code: code ?? this.code,
      userId: userId ?? this.userId,
      pointsEarned: pointsEarned ?? this.pointsEarned,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object> get props => [code, userId, pointsEarned, createdAt];
}