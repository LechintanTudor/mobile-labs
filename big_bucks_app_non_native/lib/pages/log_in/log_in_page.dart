import 'package:big_bucks_app/pages/expense_list/expense_list_page.dart';
import 'package:big_bucks_app/pages/log_in/cubit/log_in_cubit.dart';
import 'package:big_bucks_app/pages/log_in/cubit/log_in_state.dart';
import 'package:big_bucks_app/pages/register/register_page.dart';
import 'package:big_bucks_app/components/user_log_in_form.dart';
import 'package:big_bucks_app/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogInCubit, LogInState>(
      listener: (context, state) {
        if (state.expenseRepository != null) {
          Navigator.pushAndRemoveUntil(
            context,
            ExpenseListPage.route(expenseRepository: state.expenseRepository!),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        var logInCubit = context.read<LogInCubit>();

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Text('Log In'),
          ),
          body: Center(
            child: UserLogInForm(
              onLogInPressed: (credentials) {
                logInCubit.logIn(credentials);
              },
              onRegisterPressed: () {
                var userService = RepositoryProvider.of<UserService>(context);
                var route = RegisterPage.route(userService: userService);
                Navigator.push(context, route);
              },
              onUseOfflinePressed: () {
                logInCubit.useOffline();
              },
            ),
          ),
        );
      },
    );
  }
}
