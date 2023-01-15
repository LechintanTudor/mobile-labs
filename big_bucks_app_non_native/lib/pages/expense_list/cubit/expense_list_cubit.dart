import 'package:big_bucks_app/pages/expense_list/cubit/expense_list_state.dart';
import 'package:big_bucks_app/repository/abstract/expense_repository.dart';
import 'package:big_bucks_app/model/expense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseListCubit extends Cubit<ExpenseListState> {
  final ExpenseRepository _expenseRepository;

  ExpenseListCubit({required ExpenseRepository expenseRepository})
      : _expenseRepository = expenseRepository,
        super(const ExpenseListState());

  Future<void> addExpense(Expense expense) async {
    try {
      var newExpense = await _expenseRepository.add(expense);
      emit(state.copyWith(expenses: [...state.expenses, newExpense]));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }

  Future<void> getAllExpenses() async {
    try {
      emit(state.copyWith(
        expenses: await _expenseRepository.getAll(),
        selectedExpenseId: null,
      ));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }

  Future<void> updateExpense(Expense expense) async {
    try {
      if (await _expenseRepository.update(expense)) {
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
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }

  Future<void> deleteExpenseById(int expenseId) async {
    try {
      if (await _expenseRepository.deleteById(expenseId)) {
        var expenses = [...state.expenses]
          ..retainWhere((expense) => expense.id != expenseId);

        var selectedExpenseId = state.selectedExpenseId != expenseId
            ? state.selectedExpenseId
            : null;

        emit(state.copyWith(
          expenses: expenses,
          selectedExpenseId: selectedExpenseId,
        ));
      }
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }

  void clearLastError() {
    emit(state.copyWith(error: ''));
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
