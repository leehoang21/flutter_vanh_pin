import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../widgets/provider/provider_widget.dart';
import 'cubit/google_authenticator_cubit.dart';
import 'google_authenticator_screen.dart';

@RoutePage()
class GoogleAuthenticatorScreenProvider extends StatelessWidget {
  const GoogleAuthenticatorScreenProvider({super.key}) : super();

  @override
  Widget build(BuildContext context) {
    return const ProviderWidget<GoogleAuthenticatorCubit>(
      params: [],
      child: GoogleAuthenticatorScreen(),
    );
  }
}
