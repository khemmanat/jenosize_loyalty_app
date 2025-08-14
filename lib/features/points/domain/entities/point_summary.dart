import 'package:equatable/equatable.dart';
import 'point_transaction.dart';

class PointsSummary extends Equatable {
  final int totalPoints;
  final int earnedThisMonth; // positive
  final int spentThisMonth;  // positive
  final List<PointTransaction> recentTransactions;

  const PointsSummary({
    required this.totalPoints,
    required this.earnedThisMonth,
    required this.spentThisMonth,
    required this.recentTransactions,
  });

  int get netThisMonth => earnedThisMonth - spentThisMonth;

  PointsSummary copyWith({
    int? totalPoints,
    int? earnedThisMonth,
    int? spentThisMonth,
    List<PointTransaction>? recentTransactions,
  }) => PointsSummary(
    totalPoints: totalPoints ?? this.totalPoints,
    earnedThisMonth: earnedThisMonth ?? this.earnedThisMonth,
    spentThisMonth: spentThisMonth ?? this.spentThisMonth,
    recentTransactions: recentTransactions ?? this.recentTransactions,
  );

  @override
  List<Object?> get props => [totalPoints, earnedThisMonth, spentThisMonth, recentTransactions];
}