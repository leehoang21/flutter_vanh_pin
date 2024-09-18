import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/presentation/journey/settings/cubit/settings_cubit.dart';

import '../../../common/di/di.dart';
import 'settings_screen.dart';

@RoutePage()
class SettingsScreenProvider extends StatefulWidget {
  const SettingsScreenProvider({super.key});

  @override
  State<SettingsScreenProvider> createState() => _SettingsScreenProviderState();
}

class _SettingsScreenProviderState extends State<SettingsScreenProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<SettingsCubit>(),
      child: const SettingsScreen(),
    );
  }
}
