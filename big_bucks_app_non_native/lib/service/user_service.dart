import 'dart:convert';
import 'package:big_bucks_app/global/urls.dart';
import 'package:big_bucks_app/model/log_in_response.dart';
import 'package:big_bucks_app/model/user_credentials.dart';
import 'package:big_bucks_app/model/user_registration.dart';
import 'package:http/http.dart' as http;

class UserError implements Exception {
  final String message;

  const UserError(this.message);

  @override
  String toString() {
    return 'UserError: $message';
  }
}

class UserService {
  Future<void> register(UserRegistration registration) async {
    var response = await http.post(
      Uri.http(globalApiAuthority, '/users/register'),
      headers: _getCommonHeaders(),
      body: jsonEncode(registration.toJson()),
    );

    if (response.statusCode != 204) {
      throw const UserError('failed to register user');
    }
  }

  Future<LogInResponse> logIn(UserCredentials credentials) async {
    var response = await http.post(
      Uri.http(globalApiAuthority, '/users/login'),
      headers: _getCommonHeaders(),
      body: jsonEncode(credentials.toJson()),
    );

    if (response.statusCode != 201) {
      throw const UserError('failed to log in');
    }

    return LogInResponse.fromJson(jsonDecode(response.body));
  }

  Future<void> logOut({required String token}) async {
    var response = await http.post(
      Uri.http(globalApiAuthority, '/users/logout'),
      headers: _getHeadersWithToken(token),
    );

    if (response.statusCode != 200) {
      throw const UserError('failed to log out');
    }
  }

  Map<String, String> _getCommonHeaders() {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  Map<String, String> _getHeadersWithToken(String token) {
    var headers = _getCommonHeaders();
    headers['Authorization'] = 'Token $token';
    return headers;
  }
}
