class UserCredentials {
  final String username;
  final String password;

  const UserCredentials({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}
