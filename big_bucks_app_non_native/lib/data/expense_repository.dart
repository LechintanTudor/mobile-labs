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
    for (var expense in _expenses) {
      if (expense.id == id) {
        return expense;
      }
    }

    return null;
  }

  List<Expense> getAll() {
    return _expenses;
  }

  bool containsId(int id) {
    return _expenses.any((expense) => expense.id == id);
  }

  bool update(Expense expense) {
    var index =
        _expenses.indexWhere((oldExpense) => oldExpense.id == expense.id);

    if (index == -1) {
      return false;
    }

    _expenses[index] = expense;
    return true;
  }

  bool deleteById(int id) {
    var initialLength = _expenses.length;
    _expenses.removeWhere((expense) => expense.id == id);
    return _expenses.length < initialLength;
  }
}
