import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pinpin/presentation/journey/main/main_screen.dart';

import '../../widgets/provider/provider_widget.dart';
import 'bloc/tab_manger_cubit.dart';

@RoutePage()
class MainScreenProvider extends StatelessWidget {
  const MainScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderWidgetNoAsync<TabMangerCubit>(
      params: [],
      child: MainScreen(),
    );
  }
}
