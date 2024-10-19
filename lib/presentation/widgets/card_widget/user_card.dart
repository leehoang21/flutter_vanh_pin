import 'package:flutter/material.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:pinpin/presentation/journey/profile_third/cubit/profile_third_cubit.dart';
import 'package:pinpin/presentation/themes/themes.dart';
import 'package:pinpin/presentation/widgets/button_widget/text_button_widget.dart';
import 'package:pinpin/presentation/widgets/card_widget/card_custom.dart';
import 'package:pinpin/presentation/widgets/image_app_widget/avatar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/di/di.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.model,
  });
  final UserModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        bottom: 10.h,
      ),
      child: CardCustom(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AvatarWidget(path: model.avatar ?? ''),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  model.userName ?? '',
                  style: ThemeText.body2,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            TextButtonWidget2(
              onPressed: () async {
                final bloc = await getIt.getAsync<ProfileThirdCubit>();
                bloc.addFriend(model);
              },
              title: 'Add Friend'.tr,
            ),
          ],
        ),
      ),
    );
  }
}
