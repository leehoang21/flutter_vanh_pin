import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../../../../common/assets/assets.gen.dart';
import '../../../../../common/enums/login_type.dart';
import '../../login/cubit/login_cubit.dart';
import '../../login/widget/login_with_item.dart';

class AuthScaffoldConstants {
  static double sizeLogo = 100.w;
  static double distanceTextToField = 28.h;
  static double distanceButtonToField = 40.h;
  static double horizontalOr = 10.w;
  static double horizontal = 16.88.w;
  static double sizeIcon = 28.w;

  static String or = translate('or');
  static List<ItemLoginWithModel> listIconsLogin(BuildContext context) => [
        ItemLoginWithModel(
          icon: Assets.icons.icGoogle.svg(
            width: sizeIcon,
            height: sizeIcon,
          ),
          onPressed: () {
            context.read<LoginCubit>().login(LoginType.google);
          },
        ),
      ];
}
