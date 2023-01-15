import 'package:big_bucks_app/model/expense.dart';

class ExpenseError implements Exception {
  final String message;

  const ExpenseError(this.message);

  @override
  String toString() {
    return 'ExpenseError: $message';
  }
}

abstract class ExpenseRepository {
  const ExpenseRepository();

  Future<Expense> add(Expense expense);

  Future<Expense?> getById(int expenseId);

  Future<List<Expense>> getAll();

  Future<bool> update(Expense expense);

  Future<bool> deleteById(int expenseId);

  Future<void> deleteAll();
}
