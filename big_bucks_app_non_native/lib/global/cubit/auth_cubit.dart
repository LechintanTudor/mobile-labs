import 'package:big_bucks_app/global/cubit/auth_state.dart';
import 'package:big_bucks_app/model/user_credentials.dart';
import 'package:big_bucks_app/service/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserService _userService;

  AuthCubit({required UserService userService})
      : _userService = userService,
        super(const AuthState());

  Future<void> logIn(UserCredentials credentials) async {
    try {
      var response = await _userService.logIn(credentials);
      emit(state.copyWith(token: response.token, error: ''));
    } catch (error) {
      emit(state.copyWith(token: '', error: error.toString()));
    }
  }

  Future<void> logOut() async {
    if (!state.isAuthenticated) {
      return;
    }

    try {
      await _userService.logOut(token: state.token);
      emit(state.copyWith(token: '', error: ''));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }
}
