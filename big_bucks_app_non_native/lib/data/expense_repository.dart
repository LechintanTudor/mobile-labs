import 'package:big_bucks_app/model/expense.dart';

class AddExpenseError implements Exception {}

class ExpenseRepository {
  final List<Expense> _expenses = [];
  int _lastGeneratedId = 0;

  Expense add(Expense expense) {
    if (expense.id != 0) {
      throw AddExpenseError();
    }

    var id = _lastGeneratedId + 1;
    _lastGeneratedId += 1;

    var newExpense = expense.copyWith(id: id);
    _expenses.add(newExpense);
    return newExpense;
  }

  Expense? getById(int id) {
    return _expenses.firstWhere((expense) => expense.id == id);
  }

  List<Expense> getAll() {
    return _expenses;
  }

  bool containsId(int id) {
    return _expenses.any((expense) => expense.id == id);
  }

  bool deleteById(int id) {
    var initialLength = _expenses.length;
    _expenses.removeWhere((expense) => expense.id == id);
    return _expenses.length < initialLength;
  }
}
