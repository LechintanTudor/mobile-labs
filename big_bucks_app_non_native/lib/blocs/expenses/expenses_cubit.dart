import 'package:big_bucks_app/blocs/expenses/expenses_state.dart';
import 'package:big_bucks_app/data/expense_repository.dart';
import 'package:big_bucks_app/model/expense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  final ExpenseRepository _expenseRepository;

  ExpensesCubit(ExpenseRepository expenseRepository)
      : _expenseRepository = expenseRepository,
        super(const ExpensesState());

  void addExpense(Expense expense) {
    var newExpense = _expenseRepository.add(expense);
    emit(state.copyWith(expenses: [...state.expenses, newExpense]));
  }

  void getAllExpenses() {
    emit(state.copyWith(
      expenses: _expenseRepository.getAll(),
      selectedExpenseId: null,
    ));
  }

  void deleteExpenseById(int expenseId) {
    if (_expenseRepository.deleteById(expenseId)) {
      emit(state.copyWith(
        expenses:
            state.expenses.takeWhile((value) => value.id != expenseId).toList(),
        selectedExpenseId: state.selectedExpenseId != expenseId
            ? state.selectedExpenseId
            : null,
      ));
    }
  }

  void selectExpenseById(int expenseId) {
    emit(state.copyWith(selectedExpenseId: expenseId));
  }

  void toggleSelectExpenseById(int expenseId) {
    var nextSelectedExpenseId =
        expenseId != state.selectedExpenseId ? expenseId : 0;

    emit(state.copyWith(selectedExpenseId: nextSelectedExpenseId));
  }
}
