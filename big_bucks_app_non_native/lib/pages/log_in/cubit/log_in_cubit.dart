import 'package:big_bucks_app/model/user_credentials.dart';
import 'package:big_bucks_app/pages/log_in/cubit/log_in_state.dart';
import 'package:big_bucks_app/repository/http/http_expense_repository.dart';
import 'package:big_bucks_app/repository/local_db/local_db_expense_repository.dart';
import 'package:big_bucks_app/service/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInCubit extends Cubit<LogInState> {
  final UserService _userService;

  LogInCubit({required UserService userService})
      : _userService = userService,
        super(const LogInState());

  Future<void> logIn(UserCredentials credentials) async {
    try {
      var logInResponse = await _userService.logIn(credentials);
      var expenseRepository = HttpExpenseRepository(token: logInResponse.token);
      emit(LogInState(expenseRepository: expenseRepository));
    } catch (error) {
      emit(LogInState(expenseRepository: null, error: error.toString()));
    }
  }

  Future<void> useOffline() async {
    var expenseRepository = await LocalDbExpenseRepository.create();
    emit(LogInState(expenseRepository: expenseRepository));
  }
}
