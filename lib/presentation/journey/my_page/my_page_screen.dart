import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/common/extension/date_time_extension.dart';
import 'package:pinpin/presentation/journey/my_page/my_page_constants.dart';
import 'package:pinpin/presentation/themes/themes.dart';
import 'package:pinpin/presentation/widgets/button_widget/text_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/presentation/widgets/card_widget/card_custom.dart';
import 'package:pinpin/presentation/widgets/card_widget/post_card.dart';
import 'package:pinpin/presentation/widgets/image_app_widget/avatar_widget.dart';
import '../../widgets/image_app_widget/image_app.dart';
import 'cubit/my_page_cubit.dart';
import 'widget/create_post_my_page_widget.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Theme.of(context).appBarTheme.backgroundColor),
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<MyPageCubit>().init();
            },
            child: ListView(
              children: [
                CardCustom(
                  padding: EdgeInsets.zero,
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
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  child: CardCustom(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const CreatePostMyPageWidget(),
                        SizedBox(
                          height: 12.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                for (var item in context.watch<MyPageCubit>().state.posts)
                  PostCard(model: item),
              ],
            ),
          ),
        ),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.watch<MyPageCubit>().state.user.userName ?? '',
                style: ThemeText.body2,
              ),
              TextButtonWidget(
                onPressed: () {},
                title: MyPageConstants.edit,
                width: 100.w,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          _ItemInfo(
            title: MyPageConstants.email,
            value: context.watch<MyPageCubit>().state.user.email ?? '',
          ),
          _ItemInfo(
            title: MyPageConstants.phoneNumber,
            value: context.watch<MyPageCubit>().state.user.phoneNumber ?? '',
          ),
          context.watch<MyPageCubit>().state.user.birthday == null
              ? const SizedBox()
              : _ItemInfo(
                  title: MyPageConstants.birthday,
                  value: context
                      .watch<MyPageCubit>()
                      .state
                      .user
                      .birthday!
                      .formatDMY,
                ),
          _ItemInfo(
            title: MyPageConstants.liveIn,
            value: context.watch<MyPageCubit>().state.user.address ?? '',
          ),
          _ItemInfo(
            title: MyPageConstants.education,
            value: context.watch<MyPageCubit>().state.user.education ?? '',
          ),
          _ItemInfo(
            title: MyPageConstants.job,
            value: context.watch<MyPageCubit>().state.user.job ?? '',
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

class _WallPaperAndAvatarWidget extends StatelessWidget {
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
              path: context.watch<MyPageCubit>().state.user.background ?? '',
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
              path: context.watch<MyPageCubit>().state.user.avatar,
            ),
          ),
        ],
      ),
    );
  }
}
