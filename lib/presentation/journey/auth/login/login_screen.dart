import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/common/enums/login_type.dart';

import '../../../../common/assets/assets.gen.dart';
import '../../../../common/constants/app_dimens.dart';
import '../../../../common/utils/validator.dart';
import '../../../routers/app_router.dart';
import '../../../themes/themes.dart';
import '../../../widgets/button_widget/text_button_widget.dart';
import '../../../widgets/text_field_widget/text_field_widget.dart';
import '../widgets/auth_scaffold/auth_scaffold.dart';
import 'cubit/login_cubit.dart';
import 'login_constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final TextEditingController controllerPassword = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return AuthScaffold(
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: LoginConstants.topHeightLogo),
              child: Assets.images.logoSplash.image(
                height: LoginConstants.sizeLogo,
                width: LoginConstants.sizeLogo,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LoginConstants.login,
                  style: ThemeText.style18Bold,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: LoginConstants.distanceTextToField),
                  child: TextFieldWidget(
                    controller: controller,
                    hintText: LoginConstants.hintEmail,
                    validate: AppValidator.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    textStyle: ThemeText.style14Medium
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: LoginConstants.distanceTextToField),
                  child: SecurityTextFieldWidget(
                    controller: controllerPassword,
                    keyboardType: TextInputType.text,
                    validate: AppValidator.validatePassword,
                    hintText: LoginConstants.yourPassword,
                    textStyle: ThemeText.style14Medium
                        .copyWith(fontWeight: FontWeight.normal),
                    onEditingComplete: () {
                      final currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus &&
                          currentFocus.focusedChild != null) {
                        FocusManager.instance.primaryFocus!.unfocus();
                      }
                      if (formKey.currentState!.validate()) {
                        context.read<LoginCubit>().login(
                              LoginType.password,
                              email: controller.text,
                              password: controllerPassword.text,
                            );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: LoginConstants.distanceButtonToField,
                  ),
                  child: TextButtonWidget(
                    onPressed: () async {
                      final currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus &&
                          currentFocus.focusedChild != null) {
                        FocusManager.instance.primaryFocus!.unfocus();
                      }
                      if (formKey.currentState!.validate()) {
                        context.read<LoginCubit>().login(
                              LoginType.password,
                              email: controller.text,
                              password: controllerPassword.text,
                            );
                      }
                    },
                    title: LoginConstants.signIn,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: AppDimens.width_12),
                    child: RichText(
                        text: TextSpan(
                      text: '${LoginConstants.notHaveAccount} ',
                      style: ThemeText.caption,
                      children: [
                        TextSpan(
                          text: LoginConstants.register,
                          style: ThemeText.caption.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.router.replace(const RegisterRoute());
                            },
                        ),
                      ],
                    )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
