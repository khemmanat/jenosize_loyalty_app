import 'package:jenosize_loyalty_app/features/points/domain/entities/point_transaction.dart';

class PointTransactionModel extends PointTransaction {
  const PointTransactionModel({
    required super.id,
    required super.type,
    required super.amount,
    required super.description,
    required super.date,
  });

  factory PointTransactionModel.fromJson(Map<String, dynamic> json) {
    return PointTransactionModel(
      id: json['id'],
      type: TransactionType.values.firstWhere(
            (e) => e.toString() == 'TransactionType.${json['type']}',
      ),
      amount: json['amount'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString().split('.').last,
      'amount': amount,
      'description': description,
      'date': date.toIso8601String(),
    };
  }
}