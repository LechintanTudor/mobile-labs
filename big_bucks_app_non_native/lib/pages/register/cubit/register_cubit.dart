import 'package:big_bucks_app/model/user_registration.dart';
import 'package:big_bucks_app/pages/register/cubit/register_state.dart';
import 'package:big_bucks_app/service/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final UserService _userService;

  RegisterCubit({
    required UserService userService,
  })  : _userService = userService,
        super(const RegisterState());

  Future<void> register(UserRegistration registration) async {
    try {
      await _userService.register(registration);
      emit(const RegisterState(success: true));
    } catch (error) {
      emit(RegisterState(success: false, error: error.toString()));
    }
  }
}
