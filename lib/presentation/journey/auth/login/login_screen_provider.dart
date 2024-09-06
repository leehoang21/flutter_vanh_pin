import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/di/di.dart';
import 'cubit/login_cubit.dart';
import 'login_screen.dart';

@RoutePage()
class LoginScreenProvider extends StatefulWidget {
  const LoginScreenProvider({super.key});

  @override
  State<LoginScreenProvider> createState() => _LoginScreenProviderState();
}

class _LoginScreenProviderState extends State<LoginScreenProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<LoginCubit>(),
      child: LoginScreen(),
    );
  }
}
