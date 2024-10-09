import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/presentation/themes/themes.dart';

import '../../../common/assets/assets.gen.dart';
import '../../../common/di/di.dart';
import '../../routers/app_router.dart';
import 'splash_controller.dart';

@RoutePage()
class SplashScreenProvider extends StatefulWidget {
  const SplashScreenProvider({super.key});

  @override
  State<SplashScreenProvider> createState() => _SplashScreenProviderState();
}

class _SplashScreenProviderState extends State<SplashScreenProvider> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    SplashController controller = await getIt.getAsync<SplashController>();
    controller.login().then((value) {
      if (value) {
        AutoRouter.of(context).replace(const HomeRoute());
      } else {
        AutoRouter.of(context).replace(const LoginRoute());
      }
    });
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
