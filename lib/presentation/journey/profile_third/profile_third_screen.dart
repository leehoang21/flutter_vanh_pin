import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/common/extension/date_time_extension.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/presentation/routers/app_router.dart';
import 'package:pinpin/presentation/themes/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/presentation/widgets/button_widget/text_button_widget.dart';
import 'package:pinpin/presentation/widgets/image_app_widget/avatar_widget.dart';
import '../../../common/service/app_service.dart';
import '../../widgets/image_app_widget/image_app.dart';
import 'cubit/profile_third_cubit.dart';
import 'profile_third_constants.dart';
import 'package:pinpin/data/models/chat_model.dart';

class ProfileThirdScreen extends StatefulWidget {
  const ProfileThirdScreen({Key? key}) : super(key: key);

  @override
  State<ProfileThirdScreen> createState() => _ProfileThirdScreenState();
}

class _ProfileThirdScreenState extends State<ProfileThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          const _WallPaperAndAvatarWidget(),
          SizedBox(
            height: 10.h,
          ),
          const _Info(),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                context.watch<ProfileThirdCubit>().state.user.userName ?? '',
                style: ThemeText.body2,
              ),
              const Spacer(),
              TextButtonWidget2(
                onPressed: () {
                  context.read<ProfileThirdCubit>().addFriend();
                },
                title: ProfileThirdConstants.addFriend.tr,
              ),
              SizedBox(
                width: 10.w,
              ),
              TextButtonWidget2(
                onPressed: () {
                  final user = context.read<ProfileThirdCubit>().state.user;
                  final members = [
                    user,
                    context.read<AppService>().state.user!,
                  ];
                  context.pushRoute(
                    ChatDetailRoute(
                      model: ChatModel(
                        chatAvatar: user.avatar,
                        chatName: user.userName,
                        chatType: ChatType.single,
                        members: members,
                        memberIds: members.map((e) => e.uId ?? '').toList(),
                      ),
                      members: members,
                    ),
                  );
                },
                title: ProfileThirdConstants.inbox.tr,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          const _ItemInfo(
            title: ProfileThirdConstants.email,
            value: '*************',
          ),
          const _ItemInfo(
            title: ProfileThirdConstants.phoneNumber,
            value: '*************',
          ),
          context.watch<ProfileThirdCubit>().state.user.birthday == null
              ? const SizedBox()
              : _ItemInfo(
                  title: ProfileThirdConstants.birthday,
                  value: context
                      .watch<ProfileThirdCubit>()
                      .state
                      .user
                      .birthday!
                      .formatDMY,
                ),
          _ItemInfo(
            title: ProfileThirdConstants.liveIn,
            value: context.watch<ProfileThirdCubit>().state.user.address ?? '',
          ),
          _ItemInfo(
            title: ProfileThirdConstants.education,
            value:
                context.watch<ProfileThirdCubit>().state.user.education ?? '',
          ),
          _ItemInfo(
            title: ProfileThirdConstants.job,
            value: context.watch<ProfileThirdCubit>().state.user.job ?? '',
          ),
        ],
      ),
    );
  }
}

class _ItemInfo extends StatelessWidget {
  const _ItemInfo({
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: ThemeText.body2,
        text: '$title: ',
        children: [
          TextSpan(
            text: value,
            style: ThemeText.caption,
          ),
        ],
      ),
    );
  }
}

class _WallPaperAndAvatarWidget extends StatelessWidget
    implements PreferredSize {
  const _WallPaperAndAvatarWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (160 + (80.sp / 2)).h,
      width: 1.sw,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: AppImageWidget(
              path: context.watch<ProfileThirdCubit>().state.user.background ??
                  '',
              fit: BoxFit.fill,
              height: 160.h,
              width: 1.sw,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 40.sp,
            height: 80.sp,
            width: 80.sp,
            child: AvatarWidget(
              path: context.watch<ProfileThirdCubit>().state.user.avatar,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget get child => Container();

  @override
  Size get preferredSize => Size(
        1.sw,
        (160 + (80.sp / 2)).h,
      );
}
