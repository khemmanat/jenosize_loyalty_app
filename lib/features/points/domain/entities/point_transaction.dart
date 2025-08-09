import 'package:equatable/equatable.dart';

enum TransactionType { earned, spent, bonus }

class PointTransaction extends Equatable {
  final String id;
  final TransactionType type;
  final int amount;
  final String description;
  final DateTime date;

  const PointTransaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.date,
  });

  PointTransaction copyWith({
    String? id,
    TransactionType? type,
    int? amount,
    String? description,
    DateTime? date,
  }) {
    return PointTransaction(
      id: id ?? this.id,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }

  @override
  List<Object> get props => [id, type, amount, description, date];
}