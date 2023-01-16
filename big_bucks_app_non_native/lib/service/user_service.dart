import 'dart:convert';
import 'package:big_bucks_app/global/urls.dart';
import 'package:big_bucks_app/model/log_in_response.dart';
import 'package:big_bucks_app/model/user_credentials.dart';
import 'package:big_bucks_app/model/user_registration.dart';
import 'package:flutter/widgets.dart';
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
    debugPrint('UserService.register');

    var response = await http.post(
      Uri.http(globalApiAuthority, '/users/register'),
      headers: _getCommonHeaders(),
      body: jsonEncode(registration.toJson()),
    );

    if (response.statusCode != 201) {
      debugPrint('UserService.register error');
      throw const UserError('failed to register user');
    }
  }

  Future<LogInResponse> logIn(UserCredentials credentials) async {
    debugPrint('UserService.logIn');

    var response = await http.post(
      Uri.http(globalApiAuthority, '/users/login'),
      headers: _getCommonHeaders(),
      body: jsonEncode(credentials.toJson()),
    );

    if (response.statusCode != 200) {
      debugPrint('UserService.logIn error');
      throw const UserError('failed to log in');
    }

    return LogInResponse.fromJson(jsonDecode(response.body));
  }

  Future<void> logOut({required String token}) async {
    debugPrint('UserService.logOut');

    var response = await http.post(
      Uri.http(globalApiAuthority, '/users/logout'),
      headers: _getHeadersWithToken(token),
    );

    if (response.statusCode != 200) {
      debugPrint('UserService.logOut error');
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
