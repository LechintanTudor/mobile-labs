import 'package:big_bucks_app/model/expense.dart';
import 'package:equatable/equatable.dart';

class ExpenseListState extends Equatable {
  final List<Expense> expenses;
  final int selectedExpenseId;
  final String error;
  final bool isOnline;

  const ExpenseListState({
    this.expenses = const <Expense>[],
    this.selectedExpenseId = 0,
    this.error = '',
    required this.isOnline,
  });

  ExpenseListState copyWith({
    List<Expense>? expenses,
    int? selectedExpenseId,
    String error = '',
  }) {
    return ExpenseListState(
      expenses: expenses ?? this.expenses,
      selectedExpenseId: selectedExpenseId ?? this.selectedExpenseId,
      error: error,
      isOnline: isOnline,
    );
  }

  bool isOk() {
    return error.isEmpty;
  }

  @override
  List<Object?> get props => [expenses, selectedExpenseId, error];

  Expense? findSelectedExpense() {
    for (var expense in expenses) {
      if (expense.id == selectedExpenseId) {
        return expense;
      }
    }

    return null;
  }
}
