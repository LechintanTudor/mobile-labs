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
        debugPrint('${state.success}');

        if (state.success) {
          Navigator.pop(context);
        } else if (state.error != '') {
          _showErrorDialog(context, error: state.error);
        }
      },
      builder: (context, state) {
        var registerCubit = context.read<RegisterCubit>();

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Text('Register'),
          ),
          body: UserRegisterForm(
            onRegisterPressed: (registration) {
              registerCubit.register(registration);
            },
            onCancelPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}

void _showSuccessDialog(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Success'),
      content: const Text('Registered successfully'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        )
      ],
    ),
  );
}

void _showErrorDialog(
  BuildContext context, {
  required String error,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Error'),
      content: Text(error),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
