import 'package:big_bucks_app/components/user_register_form.dart';
import 'package:big_bucks_app/pages/register/cubit/register_cubit.dart';
import 'package:big_bucks_app/pages/register/cubit/register_state.dart';
import 'package:big_bucks_app/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static MaterialPageRoute route({
    required UserService userService,
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (context) => RegisterCubit(userService: userService),
          child: const RegisterPage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.success) {
          showSuccessDialog(context);
          Navigator.pop(context);
        } else if (state.error != '') {
          showDialog(
            context: context,
            builder: (context) => showErrorDialog(
              context,
              error: state.error,
            ),
          );
        }
      },
      builder: (context, state) {
        var registerCubit = context.read<RegisterCubit>();

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Text('Register'),
          ),
          body: Center(
            child: UserRegisterForm(
              onRegisterPressed: (registration) {
                registerCubit.register(registration);
              },
              onCancelPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }
}

Widget showSuccessDialog(
  BuildContext context,
) {
  return AlertDialog(
    title: const Text('Success'),
    content: const Text('Registered successfully'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('OK'),
      )
    ],
  );
}

Widget showErrorDialog(
  BuildContext context, {
  required String error,
}) {
  return AlertDialog(
    title: const Text('Error'),
    content: Text(error),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('OK'),
      ),
    ],
  );
}
