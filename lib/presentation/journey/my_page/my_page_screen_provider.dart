import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../widgets/provider/provider_widget.dart';
import 'cubit/my_page_cubit.dart';
import 'my_page_screen.dart';

@RoutePage()
class MyPageScreenProvider extends StatelessWidget {
  const MyPageScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderWidget<MyPageCubit>(
      params: [],
      child: MyPageScreen(),
    );
  }
}
