import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/injection_container.dart' as di;
import '../../domain/entities/point_transaction.dart';
import '../../domain/usecases/get_points_balance.dart';
import '../../domain/usecases/get_transaction_history.dart';

class PointsState {
  final int balance;
  final List<PointTransaction> transactions;
  final bool isLoading;
  final String? error;

  const PointsState({
    this.balance = 0,
    this.transactions = const [],
    this.isLoading = false,
    this.error,
  });

  PointsState copyWith({
    int? balance,
    List<PointTransaction>? transactions,
    bool? isLoading,
    String? error,
  }) {
    return PointsState(
      balance: balance ?? this.balance,
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class PointsNotifier extends StateNotifier<PointsState> {
  final GetPointsBalance _getPointsBalance;
  final GetTransactionHistory _getTransactionHistory;

  PointsNotifier(this._getPointsBalance, this._getTransactionHistory)
      : super(const PointsState()) {
    loadPoints();
  }

  Future<void> loadPoints() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final balance = await _getPointsBalance();
      final transactions = await _getTransactionHistory();

      state = state.copyWith(
        balance: balance,
        transactions: transactions,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final pointsProvider = StateNotifierProvider<PointsNotifier, PointsState>((ref) {
  return PointsNotifier(
    di.sl<GetPointsBalance>(),
    di.sl<GetTransactionHistory>(),
  );
});