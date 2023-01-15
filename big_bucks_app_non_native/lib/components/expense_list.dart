import 'package:big_bucks_app/components/expense_card.dart';
import 'package:big_bucks_app/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> _expenses;
  final int? _selectedExpenseId;
  final void Function(int expenseId) _onCardPressed;
  final void Function(int expenseId) _onEditPressed;
  final void Function(int expenseId) _onDeletePressed;

  const ExpenseList({
    super.key,
    required List<Expense> expenses,
    int? selectedExpenseId,
    required void Function(int expenseId) onCardPressed,
    required void Function(int expenseId) onEditPressed,
    required void Function(int expenseId) onDeletePressed,
  })  : _expenses = expenses,
        _selectedExpenseId = selectedExpenseId,
        _onCardPressed = onCardPressed,
        _onEditPressed = onEditPressed,
        _onDeletePressed = onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        itemCount: _expenses.length,
        itemBuilder: (context, index) {
          var expense = _expenses[index];

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ExpenseCard(
              expense: expense,
              onCardPressed: () => _onCardPressed(expense.id),
              onEditPressed: () => _onEditPressed(expense.id),
              onDeletePressed: () => _onDeletePressed(expense.id),
              expanded: expense.id == _selectedExpenseId,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 8,
          );
        },
      ),
    );
  }
}
