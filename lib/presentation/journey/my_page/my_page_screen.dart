import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pin/common/extension/date_time_extension.dart';
import 'package:flutter_pin/data/models/user_model.dart';
import 'package:flutter_pin/presentation/journey/my_page/my_page_constants.dart';
import 'package:flutter_pin/presentation/themes/themes.dart';
import 'package:flutter_pin/presentation/widgets/button_widget/text_button_widget.dart';
import 'package:flutter_pin/presentation/widgets/card_widget/post_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/post_model.dart';
import '../../widgets/image_app_widget/image_app.dart';
import 'cubit/my_page_cubit.dart';

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
              context.read<MyPageCubit>().onInit();
            },
            child: ListView(
              children: [
                const _WallPaperAndAvatarWidget(),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 20.h,
                ),
                const _Info(),
                SizedBox(
                  height: 10.h,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    for (var i = 0; i < 10; i++)
                      PostCard(
                        model: PostModel(
                          images: [
                            'https://cellphones.com.vn/sforum/wp-content/uploads/2024/02/anh-thien-nhien-1.jpg'
                          ],
                          author: const UserModel(
                            avatar:
                                'https://cellphones.com.vn/sforum/wp-content/uploads/2024/02/anh-thien-nhien-1.jpg',
                            userName: 'Nguyen Van A',
                          ),
                          group: const UserModel(
                            avatar:
                                'https://cellphones.com.vn/sforum/wp-content/uploads/2024/02/anh-thien-nhien-1.jpg',
                            userName: 'Group A',
                          ),
                          time: DateTime.now()
                              .subtract(const Duration(minutes: 10)),
                          content:
                              'Trang Web phối màu online của adobe, điều chỉnh màu, lấy màu từ ảnh (hay hơn nữa là chọn màu từ điểm ảnh mà bạn chọn).',
                        ),
                      )
                  ],
                ),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(500),
              child: AppImageWidget(
                path: context.watch<MyPageCubit>().state.user.avatar,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
