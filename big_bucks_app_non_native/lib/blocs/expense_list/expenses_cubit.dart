import 'package:big_bucks_app/blocs/expense_list/expenses_state.dart';
import 'package:big_bucks_app/data/expense_repository.dart';
import 'package:big_bucks_app/model/expense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseListCubit extends Cubit<ExpenseListState> {
  final ExpenseRepository _expenseRepository;

  ExpenseListCubit(ExpenseRepository expenseRepository)
      : _expenseRepository = expenseRepository,
        super(const ExpenseListState());

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

  void updateExpense(Expense expense) {
    if (_expenseRepository.update(expense)) {
      var expenses = state.expenses.map(
        (oldExpense) {
          if (oldExpense.id != expense.id) {
            return oldExpense;
          } else {
            return expense;
          }
        },
      ).toList();

      emit(state.copyWith(expenses: expenses));
    }
  }

  void deleteExpenseById(int expenseId) {
    if (_expenseRepository.deleteById(expenseId)) {
      var expenses = state.expenses
          .takeWhile((expense) => expense.id != expenseId)
          .toList();

      var selectedExpenseId =
          state.selectedExpenseId != expenseId ? state.selectedExpenseId : null;

      emit(state.copyWith(
        expenses: expenses,
        selectedExpenseId: selectedExpenseId,
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
