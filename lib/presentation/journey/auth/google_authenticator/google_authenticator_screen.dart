import 'package:flutter/material.dart';

import 'widget/otp_widget.dart';

class GoogleAuthenticatorScreen extends StatelessWidget {
  const GoogleAuthenticatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OtpWidget(),
    );
  }
}
