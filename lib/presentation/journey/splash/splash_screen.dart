import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../routers/app_router.dart';
import '../../widgets/loading_widget/loader_widget.dart';

@RoutePage()
class SplashScreenProvider extends StatefulWidget {
  const SplashScreenProvider({super.key});

  @override
  State<SplashScreenProvider> createState() => _SplashScreenProviderState();
}

class _SplashScreenProviderState extends State<SplashScreenProvider> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      AutoRouter.of(context).replace(const HomeRoute());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoaderWidget(),
    );
  }
}
