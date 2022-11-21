import 'package:big_bucks_app/model/expense.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class ExpensesState extends Equatable {
  final List<Expense> expenses;
  final int selectedExpenseId;

  const ExpensesState({
    this.expenses = const <Expense>[],
    this.selectedExpenseId = 1,
  });

  ExpensesState copyWith({List<Expense>? expenses, int? selectedExpenseId}) {
    return ExpensesState(
      expenses: expenses ?? this.expenses,
      selectedExpenseId: selectedExpenseId ?? this.selectedExpenseId,
    );
  }

  @override
  List<Object?> get props => [expenses, selectedExpenseId];

  Expense? findSelectedExpense() {
    return expenses.firstWhere((expense) => expense.id == selectedExpenseId);
  }
}
