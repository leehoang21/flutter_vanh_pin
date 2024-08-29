import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/di/di.dart';
import 'cubit/my_page_cubit.dart';
import 'my_page_screen.dart';

@RoutePage()
class MyPageScreenProvider extends StatefulWidget {
  const MyPageScreenProvider({super.key});

  @override
  State<MyPageScreenProvider> createState() => _MyPageScreenProviderState();
}

class _MyPageScreenProviderState extends State<MyPageScreenProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt.get<MyPageCubit>(),
        child: const MyPageScreen());
  }
}
