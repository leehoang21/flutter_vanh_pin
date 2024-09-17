import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/presentation/themes/themes.dart';

import '../../../common/assets/assets.gen.dart';
import '../../routers/app_router.dart';

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
      AutoRouter.of(context).replace(const LoginRoute());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Assets.images.logoSplash.image(
          fit: BoxFit.cover,
          width: 120.sp,
          height: 120.sp,
        ),
      ),
    );
  }
}
