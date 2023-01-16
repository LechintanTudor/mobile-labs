import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final String token;
  final String error;

  const AuthState({this.token = '', this.error = ''});

  AuthState copyWith({String? token, String? error}) {
    return AuthState(
      token: token ?? this.token,
      error: error ?? this.error,
    );
  }

  bool get isAuthenticated => token.isNotEmpty;

  @override
  List<Object?> get props => [token, error];
}
