import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/data/models/chat_model.dart';
import 'package:pinpin/presentation/themes/themes.dart';
import 'package:pinpin/presentation/widgets/button_widget/text_button_widget.dart';
import 'package:pinpin/presentation/widgets/image_app_widget/avatar_widget.dart';

import '../../../../data/models/user_model.dart';
import '../../../widgets/check_box/check_box_cricle_widget.dart';
import '../../../widgets/provider/provider_widget.dart';
import '../cubit/chat_detail_option_cubit.dart';

class MembersWidget extends StatelessWidget {
  const MembersWidget({
    super.key,
    required this.title,
    required this.onPressed,
    required this.model,
    required this.users,
  });

  final Function(List<UserModel>)? onPressed;
  final String title;
  final ChatModel model;
  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ChatDetailOptionCubit>(
      params: [model, users],
      child: Builder(builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 1.sw,
            ),
            Text(
              title,
              style: ThemeText.headline6,
            ),
            for (var data in context.watch<ChatDetailOptionCubit>().state.users)
              _ItemMember(
                data: data,
                isCheckbox: onPressed != null,
              ),
            onPressed == null
                ? const SizedBox()
                : TextButtonWidget2(
                    onPressed: () {
                      onPressed!(context
                          .read<ChatDetailOptionCubit>()
                          .state
                          .users
                          .map((e) => e.$2)
                          .toList());
                    },
                    title: title,
                  ),
          ],
        );
      }),
    );
  }
}

class _ItemMember extends StatelessWidget {
  const _ItemMember({
    required this.data,
    required this.isCheckbox,
  });
  final (bool, UserModel) data;
  final bool isCheckbox;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 5.h,
      ),
      child: Row(
        children: [
          AvatarWidget(path: data.$2.avatar),
          SizedBox(width: 5.w),
          Text(
            data.$2.userName ?? '',
            style: ThemeText.caption,
          ),
          const Spacer(),
          if (isCheckbox)
            GestureDetector(
                onTap: () {
                  context
                      .read<ChatDetailOptionCubit>()
                      .changeUser(!data.$1, data.$2);
                },
                child: CheckboxCricleWidget(value: data.$1)),
          SizedBox(width: 10.w),
        ],
      ),
    );
  }
}
