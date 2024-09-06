import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/di/di.dart';
import 'cubit/register_cubit.dart';
import 'register_screen.dart';

@RoutePage()
class RegisterScreenProvider extends StatelessWidget {
  const RegisterScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<RegisterCubit>(),
      child: const RegisterScreen(),
    );
  }
}
