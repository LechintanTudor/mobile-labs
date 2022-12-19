import 'package:big_bucks_app/model/expense.dart';
import 'package:equatable/equatable.dart';

class ExpenseListState extends Equatable {
  final List<Expense> expenses;
  final int selectedExpenseId;
  final String lastError;

  const ExpenseListState({
    this.expenses = const <Expense>[],
    this.selectedExpenseId = 0,
    this.lastError = '',
  });

  ExpenseListState copyWith({
    List<Expense>? expenses,
    int? selectedExpenseId,
    String? lastError,
  }) {
    return ExpenseListState(
      expenses: expenses ?? this.expenses,
      selectedExpenseId: selectedExpenseId ?? this.selectedExpenseId,
      lastError: lastError ?? this.lastError,
    );
  }

  bool isOk() {
    return lastError.isEmpty;
  }

  @override
  List<Object?> get props => [expenses, selectedExpenseId, lastError];

  Expense? findSelectedExpense() {
    for (var expense in expenses) {
      if (expense.id == selectedExpenseId) {
        return expense;
      }
    }

    return null;
  }
}
