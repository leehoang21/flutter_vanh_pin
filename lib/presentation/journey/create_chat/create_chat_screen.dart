import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/data/models/chat_model.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/presentation/journey/create_chat/create_chat_constants.dart';
import 'package:pinpin/presentation/journey/create_chat/cubit/create_chat_cubit.dart';
import 'package:pinpin/presentation/routers/app_router.dart';
import '../../themes/themes.dart';
import '../../widgets/image_app_widget/avatar_widget.dart';
import '../../widgets/text_field_widget/search_field_widget.dart';

class CreateChatScreen extends StatefulWidget {
  const CreateChatScreen({Key? key}) : super(key: key);

  @override
  State<CreateChatScreen> createState() => _CreateChatScreenState();
}

class _CreateChatScreenState extends State<CreateChatScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      child: ListView(
        children: [
          SizedBox(
            height: 5.h,
          ),
          Center(
            child: Text(
              CreateChatConstants.title,
              style: ThemeText.style18Bold,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          SearchFieldWidget(
              controller: _searchController,
              onChanged: (value) {
                context.read<CreateChatCubit>().searchUser(value);
              }),
          SizedBox(
            height: 15.h,
          ),
          for (final item in context.watch<CreateChatCubit>().state.users ?? [])
            _ItemChat(data: item),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}

class _ItemChat extends StatefulWidget {
  const _ItemChat({required this.data});
  final UserModel data;

  @override
  State<_ItemChat> createState() => _ItemChatState();
}

class _ItemChatState extends State<_ItemChat> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final members = [
          widget.data,
          context.read<AppService>().state.user!,
        ];
        context.pushRoute(
          ChatDetailRoute(
            model: ChatModel(
              chatAvatar: widget.data.avatar,
              chatName: widget.data.userName,
              chatType: ChatType.single,
              members: members,
              memberIds: members.map((e) => e.uId ?? '').toList(),
            ),
            members: members,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 10.h,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AvatarWidget(
              path: widget.data.avatar,
              size: 40.sp,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              widget.data.userName ?? '',
              style: ThemeText.style12Regular,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
