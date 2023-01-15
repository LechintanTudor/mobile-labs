import 'package:big_bucks_app/model/user_credentials.dart';
import 'package:flutter/material.dart';

class UserLogInForm extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final void Function(UserCredentials credentials) _onLogInPressed;
  final void Function() _onRegisterPressed;
  final void Function() _onUseOfflinePressed;

  UserLogInForm({
    super.key,
    required void Function(UserCredentials credentials) onLogInPressed,
    required void Function() onRegisterPressed,
    required void Function() onUseOfflinePressed,
  })  : _onLogInPressed = onLogInPressed,
        _onRegisterPressed = onRegisterPressed,
        _onUseOfflinePressed = onUseOfflinePressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(hintText: "Username"),
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: "Password"),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  _onLogInPressed(getUserCredentials());
                },
                child: const Text('Log In'),
              ),
              ElevatedButton(
                onPressed: _onRegisterPressed,
                child: const Text('Register'),
              ),
              ElevatedButton(
                onPressed: _onUseOfflinePressed,
                child: const Text('Use offline'),
              )
            ],
          ),
        ),
      ),
    );
  }

  UserCredentials getUserCredentials() {
    return UserCredentials(
      username: _usernameController.text,
      password: _passwordController.text,
    );
  }
}
