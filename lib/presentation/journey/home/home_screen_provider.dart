import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/di/di.dart';
import 'cubit/home_cubit.dart';
import 'home_screen.dart';

@RoutePage()
class HomeScreenProvider extends StatefulWidget {
  const HomeScreenProvider({super.key});

  @override
  State<HomeScreenProvider> createState() => _HomeScreenProviderState();
}

class _HomeScreenProviderState extends State<HomeScreenProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt.get<HomeCubit>(), child: const HomeScreen());
  }
}
