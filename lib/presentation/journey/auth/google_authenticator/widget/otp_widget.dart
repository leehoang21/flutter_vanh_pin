import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pinpin/presentation/journey/auth/google_authenticator/cubit/google_authenticator_cubit.dart';

import '../../../../themes/themes.dart';
import '../../../../widgets/button_widget/text_button_widget.dart';
import '../google_authenticator_contants.dart';

class OtpWidget extends StatelessWidget {
  OtpWidget({Key? key}) : super(key: key);
  final TextEditingController pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          GoogleAuthenticatorScreenContants.description,
          style: ThemeText.caption.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        PinCodeTextField(
          keyboardType: TextInputType.number,
          cursorColor: AppColor.taupeGray,
          appContext: context,
          length: 6,
          controller: pinCodeController,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(6),
            fieldHeight: GoogleAuthenticatorScreenContants.widthFieldInput,
            fieldWidth: GoogleAuthenticatorScreenContants.widthFieldInput,
            borderWidth: 2,
            activeColor: AppColor.taupeGray,
            inactiveColor: AppColor.platinum,
            selectedColor: AppColor.taupeGray,
          ),
        ),
        TextButtonWidget2(
          onPressed: () {
            context
                .read<GoogleAuthenticatorCubit>()
                .verify(pinCodeController.text);
          },
          title: GoogleAuthenticatorScreenContants.confirm,
        ),
      ],
    );
  }
}
