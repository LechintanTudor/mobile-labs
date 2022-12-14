import 'package:big_bucks_app/components/presentational/expense_card.dart';
import 'package:big_bucks_app/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> _expenses;
  final int? _selectedExpenseId;
  final void Function(int expenseId)? _onCardPressed;
  final void Function(int expenseId)? _onEditPressed;
  final void Function(int expenseId)? _onDeletePressed;

  const ExpenseList({
    super.key,
    required List<Expense> expenses,
    int? selectedExpenseId,
    void Function(int expenseId)? onCardPressed,
    void Function(int expenseId)? onEditPressed,
    void Function(int expenseId)? onDeletePressed,
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
              onCardPressed: expenseIdConsumer(_onCardPressed, expense.id),
              onEditPressed: expenseIdConsumer(_onEditPressed, expense.id),
              onDeletePressed: expenseIdConsumer(_onDeletePressed, expense.id),
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

void Function()? expenseIdConsumer(
  void Function(int expenseId)? expenseIdConsumer,
  int expenseId,
) {
  return expenseIdConsumer != null ? () => expenseIdConsumer(expenseId) : null;
}
