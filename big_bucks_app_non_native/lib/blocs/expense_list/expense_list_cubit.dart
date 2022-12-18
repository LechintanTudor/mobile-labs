import 'package:big_bucks_app/blocs/expense_list/expense_list_state.dart';
import 'package:big_bucks_app/repository/abstract/expense_repository.dart';
import 'package:big_bucks_app/model/expense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseListCubit extends Cubit<ExpenseListState> {
  final ExpenseRepository _expenseRepository;

  ExpenseListCubit(ExpenseRepository expenseRepository)
      : _expenseRepository = expenseRepository,
        super(const ExpenseListState());

  Future<void> addExpense(Expense expense) async {
    var newExpense = await _expenseRepository.add(expense);
    emit(state.copyWith(expenses: [...state.expenses, newExpense]));
  }

  Future<void> getAllExpenses() async {
    emit(state.copyWith(
      expenses: await _expenseRepository.getAll(),
      selectedExpenseId: null,
    ));
  }

  Future<void> updateExpense(Expense expense) async {
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
  }

  Future<void> deleteExpenseById(int expenseId) async {
    if (await _expenseRepository.deleteById(expenseId)) {
      var expenses = [...state.expenses]
        ..retainWhere((expense) => expense.id != expenseId);

      var selectedExpenseId =
          state.selectedExpenseId != expenseId ? state.selectedExpenseId : null;

      emit(state.copyWith(
        expenses: expenses,
        selectedExpenseId: selectedExpenseId,
      ));
    }
  }

  Future<void> selectExpenseById(int expenseId) async {
    emit(state.copyWith(selectedExpenseId: expenseId));
  }

  Future<void> toggleSelectExpenseById(int expenseId) async {
    var nextSelectedExpenseId =
        expenseId != state.selectedExpenseId ? expenseId : 0;

    emit(state.copyWith(selectedExpenseId: nextSelectedExpenseId));
  }
}
