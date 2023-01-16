import 'package:big_bucks_app/global/cubit/auth_cubit.dart';
import 'package:big_bucks_app/pages/log_in/cubit/log_in_cubit.dart';
import 'package:big_bucks_app/pages/log_in/log_in_page.dart';
import 'package:big_bucks_app/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(const BigBucksApp());
}

class BigBucksApp extends StatelessWidget {
  const BigBucksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserService(),
      child: BlocProvider(
        create: (context) {
          var userService = RepositoryProvider.of<UserService>(context);
          return AuthCubit(userService: userService);
        },
        child: MaterialApp(
          title: 'BIG BUCK\$',
          home: BlocProvider(
            create: (context) {
              var userService = RepositoryProvider.of<UserService>(context);
              return LogInCubit(userService: userService);
            },
            child: const LogInPage(),
          ),
        ),
      ),
    );
  }
}
