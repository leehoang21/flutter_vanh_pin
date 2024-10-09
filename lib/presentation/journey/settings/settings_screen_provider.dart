import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:pinpin/presentation/journey/settings/cubit/settings_cubit.dart';
import '../../widgets/provider/provider_widget.dart';
import 'settings_screen.dart';

@RoutePage()
class SettingsScreenProvider extends StatelessWidget {
  const SettingsScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderWidget<SettingsCubit>(
      params: [],
      child: SettingsScreen(),
    );
  }
}
