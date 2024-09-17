import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/data/models/user_model.dart';

import '../../../common/di/di.dart';
import 'cubit/my_page_cubit.dart';
import 'my_page_screen.dart';

@RoutePage()
class MyPageScreenProvider extends StatefulWidget {
  const MyPageScreenProvider({super.key, required this.user});
  final UserModel? user;

  @override
  State<MyPageScreenProvider> createState() => _MyPageScreenProviderState();
}

class _MyPageScreenProviderState extends State<MyPageScreenProvider> {
  late final MyPageCubit myPageCubit;

  @override
  void initState() {
    myPageCubit = getIt.get<MyPageCubit>();
    myPageCubit.initState(widget.user ?? getIt.get<AppService>().user!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => myPageCubit,
      child: const MyPageScreen(),
    );
  }
}
