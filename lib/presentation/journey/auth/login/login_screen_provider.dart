import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pinpin/presentation/journey/auth/login/login_screen.dart';
import '../../../widgets/provider/provider_widget.dart';
import 'cubit/login_cubit.dart';

@RoutePage()
class LoginScreenProvider extends StatelessWidget {
  const LoginScreenProvider({super.key}) : super();

  @override
  Widget build(BuildContext context) {
    return const ProviderWidget<LoginCubit>(
      params: [],
      child: LoginScreen(),
    );
  }
}
