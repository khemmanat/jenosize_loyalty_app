import 'package:equatable/equatable.dart';
import '../../../../shared/domain/value_objects.dart';

class PointTransaction extends Equatable {
  final String id;
  final String userId;
  final int points; // + earn, - spend
  final PointTransactionType type;
  final String description;
  final String? referenceId;
  final DateTime createdAt; // store UTC

  const PointTransaction({
    required this.id,
    required this.userId,
    required this.points,
    required this.type,
    required this.description,
    this.referenceId,
    required this.createdAt,
  });

  bool get isEarned => points > 0;
  bool get isSpent => points < 0;
  int get amountAbs => points.abs();

  PointTransaction copyWith({
    String? id,
    String? userId,
    int? points,
    PointTransactionType? type,
    String? description,
    String? referenceId,
    DateTime? createdAt,
  }) => PointTransaction(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    points: points ?? this.points,
    type: type ?? this.type,
    description: description ?? this.description,
    referenceId: referenceId ?? this.referenceId,
    createdAt: createdAt ?? this.createdAt,
  );

  factory PointTransaction.fromJson(Map<String, dynamic> json) {
    return PointTransaction(
      id: json['id'] as String,
      userId: json['userId'] as String,
      points: json['points'] as int,
      type: PointTransactionType.fromString(json['type'] as String),
      description: json['description'] as String,
      referenceId: json['referenceId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  @override
  List<Object?> get props => [id, userId, points, type, description, referenceId, createdAt];
}
