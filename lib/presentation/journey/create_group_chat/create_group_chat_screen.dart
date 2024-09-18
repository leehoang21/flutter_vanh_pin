import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/common/di/di.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/presentation/journey/create_group/create_group_constants.dart';
import 'package:pinpin/presentation/widgets/text_field_widget/text_field_widget.dart';
import '../../themes/themes.dart';
import '../../widgets/button_widget/text_button_widget.dart';
import '../../widgets/image_app_widget/avatar_widget.dart';
import '../../widgets/pick_image/pick_image_widget.dart';
import 'create_group_chat_constants.dart';
import 'cubit/create_group_chat_cubit.dart';

class CreateGroupChatScreen extends StatefulWidget {
  const CreateGroupChatScreen({Key? key}) : super(key: key);

  @override
  State<CreateGroupChatScreen> createState() => _CreateGroupChatScreenState();
}

class _CreateGroupChatScreenState extends State<CreateGroupChatScreen> {
  final TextEditingController _controller = TextEditingController();
  File? avatar;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<CreateGroupChatCubit>(),
      child: Builder(builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              CreateGroupChatConstants.title,
              style: ThemeText.style18Bold,
            ),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                PickImageWidget(
                  isMultiple: false,
                  onPressed: (images) {
                    avatar = images.first;
                    setState(() {});
                  },
                ).show(context);
              },
              child: AvatarWidget(path: avatar?.path ?? ''),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextFieldWidget(
              controller: _controller,
              hintText: CreateGroupChatConstants.inputGroupName.tr,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: TextButtonWidget(
                onPressed: () {
                  context
                      .read<CreateGroupChatCubit>()
                      .createGroup(_controller.text, avatar);
                },
                title: CreateGroupConstants.create.tr,
              ),
            ),
            //padding keyboard
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            ),
          ],
        );
      }),
    );
  }
}
