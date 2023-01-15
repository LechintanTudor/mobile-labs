import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final bool success;
  final String error;

  const RegisterState({
    this.success = false,
    this.error = '',
  });

  RegisterState copyWith({
    bool? success,
    String? error,
  }) {
    return RegisterState(
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [success, error];
}
