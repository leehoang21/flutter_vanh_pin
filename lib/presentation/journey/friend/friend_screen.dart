import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/common/di/di.dart';
import 'package:pinpin/common/extension/show_extension.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/presentation/journey/friend/cubit/friend_cubit.dart';
import 'package:pinpin/presentation/widgets/appbar_widget/appbar_widget.dart';
import 'package:pinpin/presentation/widgets/button_widget/text_button_widget.dart';
import 'package:pinpin/presentation/widgets/refresh_widget.dart';
import 'package:pinpin/presentation/widgets/scaffold_wdiget/scaffold_widget.dart';
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
    return ScaffoldWidget(
      appbar: AppBarWidget(
        title: FriendConstants.title.tr,
        action: IconButton(
          onPressed: () {
            context.showBottomSheet(
              child: SizedBox(
                height: 0.8.sh,
                child: _AddFriendWidget(
                  context.read<FriendCubit>().state.users,
                ),
              ),
            );
          },
          icon: const Icon(Icons.person_add),
          color: AppColor.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: RefreshWidget(
          onRefresh: () async {
            await context.read<FriendCubit>().onInit();
          },
          child: ListView(
            children: [
              SizedBox(
                height: 15.h,
              ),
              for (final item in (context
                          .watch<AppService>()
                          .state
                          .user
                          ?.friends ??
                      <FriendModel>[])
                  .where((element) => element.status == FriendStatus.accepted)
                  .toList())
                item.user == null
                    ? const SizedBox()
                    : _ItemFriend(data: item.user!, isAdd: false),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemFriend extends StatefulWidget {
  const _ItemFriend({required this.data, required this.isAdd});
  final UserModel data;
  final bool isAdd;

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
          if (widget.isAdd)
            TextButtonWidget2(
                onPressed: () async {
                  final bloc = await getIt.getAsync<FriendCubit>();
                  bloc.addFriend(widget.data);
                },
                title: 'Add friend'.tr),
        ],
      ),
    );
  }
}

class _AddFriendWidget extends StatelessWidget {
  const _AddFriendWidget(this.users);
  final List<UserModel> users;

  @override
  Widget build(_) {
    return ListView(
      children: [
        SizedBox(
          height: 15.h,
        ),
        for (final item in (users)) _ItemFriend(data: item, isAdd: true),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
