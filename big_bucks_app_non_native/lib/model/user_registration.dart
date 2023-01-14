class UserRegistration {
  final String username;
  final String password;
  final String passwordRepeat;

  const UserRegistration({
    required this.username,
    required this.password,
    required this.passwordRepeat,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'password_repeat': passwordRepeat,
      };
}
