import 'package:big_bucks_app/repository/abstract/expense_repository.dart';
import 'package:big_bucks_app/model/expense.dart';
import 'package:collection/collection.dart';

class InMemoryExpenseRepository implements ExpenseRepository {
  final List<Expense> _expenses = [];
  int _lastGeneratedId = 0;

  @override
  Future<Expense> add(Expense expense) async {
    if (expense.id != 0) {
      throw const ExpenseError('cannot add expense with a non-zero id');
    }

    var id = _lastGeneratedId + 1;
    _lastGeneratedId += 1;

    var newExpense = expense.copyWith(id: id);
    _expenses.add(newExpense);
    return newExpense;
  }

  @override
  Future<Expense?> getById(int expenseId) async {
    return _expenses.firstWhereOrNull((expense) => expense.id == expenseId);
  }

  @override
  Future<List<Expense>> getAll() async {
    return [..._expenses];
  }

  @override
  Future<bool> update(Expense expense) async {
    var index = _expenses.indexWhere(
      (oldExpense) => oldExpense.id == expense.id,
    );

    if (index == -1) {
      return false;
    }

    _expenses[index] = expense;
    return true;
  }

  @override
  Future<bool> deleteById(int id) async {
    var initialLength = _expenses.length;
    _expenses.removeWhere((expense) => expense.id == id);
    return _expenses.length < initialLength;
  }

  @override
  Future<void> deleteAll() async {
    _expenses.clear();
  }
}
