import 'package:big_bucks_app/model/expense.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class ExpenseListState extends Equatable {
  final List<Expense> expenses;
  final int selectedExpenseId;

  const ExpenseListState({
    this.expenses = const <Expense>[],
    this.selectedExpenseId = 0,
  });

  ExpenseListState copyWith({List<Expense>? expenses, int? selectedExpenseId}) {
    return ExpenseListState(
      expenses: expenses ?? this.expenses,
      selectedExpenseId: selectedExpenseId ?? this.selectedExpenseId,
    );
  }

  @override
  List<Object?> get props => [expenses, selectedExpenseId];

  Expense? findSelectedExpense() {
    for (var expense in expenses) {
      if (expense.id == selectedExpenseId) {
        return expense;
      }
    }

    return null;
  }
}
