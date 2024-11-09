import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:pinpin/common/extension/string_extension.dart';

import '../../../themes/theme_text.dart';

class SettingGoogleAuthenticatorContants {
  static const title = 'Use an authenticator app to scan this QR code';
  static const formStart = '''
  <!DOCTYPE html>
  <html>
  <head>
  </head>
  <body>

  ''';
  static const formEnd = '''
  </body>
  </html>
''';
}

class GoogleAuthenticatorQrWidget extends StatelessWidget {
  const GoogleAuthenticatorQrWidget({Key? key, required this.content})
      : super(key: key);
  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HtmlWidget(
              SettingGoogleAuthenticatorContants.formStart +
                  content +
                  SettingGoogleAuthenticatorContants.formEnd.tr,
            ),
            Text(SettingGoogleAuthenticatorContants.title.tr,
                style: ThemeText.caption.copyWith(
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}
