import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/common/extension/show_extension.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/presentation/journey/create_chat/create_chat_screen_provider.dart';
import 'package:pinpin/presentation/journey/create_group_chat/create_group_chat_screen.dart';
import 'package:pinpin/presentation/routers/app_router.dart';
import 'package:pinpin/presentation/widgets/appbar_widget/appbar_widget.dart';
import 'package:pinpin/presentation/widgets/image_app_widget/avatar_widget.dart';
import '../../../data/models/chat_model.dart';
import '../../themes/themes.dart';
import 'chat_constants.dart';
import 'cubit/chat_cubit.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Theme.of(context).appBarTheme.backgroundColor),
        child: Scaffold(
          appBar: AppBarWidget(
            title: ChatConstants.title,
            action: Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.showBottomSheet(
                      child: SizedBox(
                          height: 0.7.sh,
                          child: const CreateChatScreenProvider()),
                    );
                  },
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                  ),
                ),
                //group
                IconButton(
                  onPressed: () {
                    context.showBottomSheet(
                      child: const CreateGroupChatScreen(),
                    );
                  },
                  icon: const Icon(
                    Icons.group_add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<ChatCubit>().onInit();
            },
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              children: [
                SizedBox(
                  height: 20.h,
                ),
                for (final data in context.watch<ChatCubit>().state.datas)
                  _ItemChat(
                    data: data,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemChat extends StatelessWidget {
  const _ItemChat({required this.data});
  final ChatModel data;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        context.pushRoute(ChatDetailRoute(model: data, members: const []));
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 10.h,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AvatarWidget(
              path: data.chatAvatar,
              size: 60.sp,
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.chatName ?? '',
                  style: ThemeText.style12Regular.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!isNullEmpty(data.chatContent))
                  Text(
                    data.chatContent!,
                    style: ThemeText.style12Regular,
                  ),
                if (!(data.updatedAt == null))
                  Text(
                    timeago.format(data.updatedAt!, locale: 'vi'),
                    style: ThemeText.style12Regular.copyWith(
                      color: AppColor.grey,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
