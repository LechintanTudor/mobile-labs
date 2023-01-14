import 'package:big_bucks_app/model/user_registration.dart';
import 'package:flutter/material.dart';

class UserRegisterForm extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordRepeatController = TextEditingController();

  final void Function(UserRegistration registration) _onRegisterPressed;
  final void Function() _onCancelPressed;

  UserRegisterForm({
    super.key,
    required void Function(UserRegistration registration) onRegisterPressed,
    required void Function() onCancelPressed,
  })  : _onRegisterPressed = onRegisterPressed,
        _onCancelPressed = onCancelPressed;

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
              TextFormField(
                controller: _passwordRepeatController,
                obscureText: true,
                decoration: const InputDecoration(hintText: "Repeat password"),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  _onRegisterPressed(getUserRegistration());
                },
                child: const Text('Register'),
              ),
              ElevatedButton(
                onPressed: _onCancelPressed,
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  UserRegistration getUserRegistration() {
    return UserRegistration(
      username: _usernameController.text,
      password: _passwordController.text,
      passwordRepeat: _passwordRepeatController.text,
    );
  }
}
