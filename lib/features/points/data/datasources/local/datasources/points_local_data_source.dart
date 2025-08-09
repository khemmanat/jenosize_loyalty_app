import 'dart:convert';

import 'package:jenosize_loyalty_app/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/entities/point_transaction.dart';
import '../../../models/point_transaction_model.dart';

abstract class PointsLocalDataSource {
  Future<int> getPointsBalance();
  Future<List<PointTransactionModel>> getTransactionHistory();
  Future<void> addPoints(int points, String description);
}

class PointsLocalDataSourceImpl implements PointsLocalDataSource {
  final SharedPreferences sharedPreferences;

  PointsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<int> getPointsBalance() async {
    return sharedPreferences.getInt(AppConstants.pointsBalanceKey) ?? AppConstants.defaultPoints;
  }

  @override
  Future<List<PointTransactionModel>> getTransactionHistory() async {
    final transactionsJson = sharedPreferences.getStringList(AppConstants.transactionHistoryKey) ?? [];

    if (transactionsJson.isEmpty) {
      // Return some mock transaction history
      return [
        PointTransactionModel(
          id: '1',
          type: TransactionType.earned,
          amount: 100,
          description: 'Welcome bonus',
          date: DateTime.now().subtract(const Duration(days: 7)),
        ),
        PointTransactionModel(
          id: '2',
          type: TransactionType.earned,
          amount: 50,
          description: 'Completed profile',
          date: DateTime.now().subtract(const Duration(days: 5)),
        ),
        PointTransactionModel(
          id: '3',
          type: TransactionType.earned,
          amount: 75,
          description: 'First purchase',
          date: DateTime.now().subtract(const Duration(days: 3)),
        ),
      ];
    }

    return transactionsJson
        .map((json) => PointTransactionModel.fromJson(jsonDecode(json)))
        .toList();
  }

  @override
  Future<void> addPoints(int points, String description) async {
    // Update balance
    final currentBalance = await getPointsBalance();
    await sharedPreferences.setInt(AppConstants.pointsBalanceKey, currentBalance + points);

    // Add transaction
    final transaction = PointTransactionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: TransactionType.earned,
      amount: points,
      description: description,
      date: DateTime.now(),
    );

    final transactions = await getTransactionHistory();
    transactions.insert(0, transaction);

    final transactionsJson = transactions.map((t) => jsonEncode(t.toJson())).toList();
    await sharedPreferences.setStringList(AppConstants.transactionHistoryKey, transactionsJson);
  }
}
