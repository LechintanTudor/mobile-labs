import 'package:big_bucks_app/components/pages/register_page.dart';
import 'package:big_bucks_app/components/presentational/user_log_in_form.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Log In'),
      ),
      body: Center(
        child: UserLogInForm(
          onLogInPressed: (credentials) {},
          onRegisterPressed: () {
            Navigator.push(context, RegisterPage.route());
          },
        ),
      ),
    );
  }
}
