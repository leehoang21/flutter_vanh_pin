import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/presentation/themes/themes.dart';

import '../../../../common/assets/assets.gen.dart';
import '../login/login_constants.dart';
import 'widget/otp_widget.dart';

class GoogleAuthenticatorScreen extends StatelessWidget {
  const GoogleAuthenticatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: LoginConstants.topHeightLogo),
              child: Assets.images.logoSplash.image(
                height: LoginConstants.sizeLogo,
                width: LoginConstants.sizeLogo,
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            OtpWidget(),
          ],
        ),
      ),
    );
  }
}
