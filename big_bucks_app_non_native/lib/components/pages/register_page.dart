import 'package:big_bucks_app/components/presentational/user_register_form.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) {
        return const RegisterPage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Register'),
      ),
      body: Center(
        child: UserRegisterForm(
          onRegisterPressed: (registration) {},
          onCancelPressed: () {},
        ),
      ),
    );
  }
}
