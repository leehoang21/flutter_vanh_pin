import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../widgets/provider/provider_widget.dart';
import 'cubit/home_cubit.dart';
import 'home_screen.dart';

@RoutePage()
class HomeScreenProvider extends StatelessWidget {
  const HomeScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderWidget<HomeCubit>(
      params: [],
      child: HomeScreen(),
    );
  }
}
