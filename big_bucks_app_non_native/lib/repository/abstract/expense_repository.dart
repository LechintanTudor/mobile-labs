import 'package:big_bucks_app/model/expense.dart';

class AddExpenseError implements Exception {}

abstract class ExpenseRepository {
  Future<Expense> add(Expense expense);

  Future<Expense?> getById(int expenseId);

  Future<List<Expense>> getAll();

  Future<bool> update(Expense expense);

  Future<bool> deleteById(int expenseId);

  Future<void> deleteAll();
}
