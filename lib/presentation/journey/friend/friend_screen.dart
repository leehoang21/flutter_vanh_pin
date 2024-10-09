import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/friend_model.dart';
import '../../themes/themes.dart';
import '../../widgets/image_app_widget/avatar_widget.dart';
import 'friend_constants.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
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
              FriendConstants.title.tr,
              style: ThemeText.style18Bold,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          for (final item in (context.watch<AppService>().state.user?.friends ??
                  <FriendModel>[])
              .where((element) => element.status == FriendStatus.accepted)
              .toList())
            item.user == null
                ? const SizedBox()
                : _ItemFriend(data: item.user!),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}

class _ItemFriend extends StatefulWidget {
  const _ItemFriend({required this.data});
  final UserModel data;

  @override
  State<_ItemFriend> createState() => _ItemFriendState();
}

class _ItemFriendState extends State<_ItemFriend> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
