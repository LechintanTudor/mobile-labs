class LogInResponse {
  final String token;

  const LogInResponse({required this.token});

  LogInResponse.fromJson(Map<String, dynamic> json) : token = json['token'];
}
