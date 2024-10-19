import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/common/assets/assets.gen.dart';
import 'package:pinpin/common/extension/show_extension.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/data/models/group_model.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:pinpin/presentation/journey/group_detail/widget/add_member_widget.dart';
import 'package:pinpin/presentation/widgets/appbar_widget/appbar_widget.dart';
import 'package:pinpin/presentation/widgets/card_widget/post_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/presentation/widgets/scaffold_wdiget/scaffold_widget.dart';
import '../../widgets/button_widget/icon_button_widget.dart';
import 'cubit/detail_group_cubit.dart';
import 'group_detail_constants.dart';
import 'widget/create_post_group_widget.dart';

class GroupDetailScreen extends StatefulWidget {
  const GroupDetailScreen({Key? key, required this.groupModel})
      : super(key: key);
  final GroupModel groupModel;

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appbar: AppBarWidget(
        title: widget.groupModel.name,
        action: IconButton(
          onPressed: () {
            context.showBottomSheet(
              child: const _MoreWidget(),
            );
          },
          icon: Assets.icons.navbarTrailingIcon.svg(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<GroupDetailCubit>().init();
        },
        child: ListView(
          children: [
            SizedBox(
              height: 8.h,
            ),
            const CreatePostGroupWidget(),
            SizedBox(
              height: 12.h,
            ),
            BlocBuilder<GroupDetailCubit, GroupDetailState>(
              builder: (context, state) {
                return Column(
                  children: state.posts
                      .map(
                        (e) => PostCard(
                          model: e,
                        ),
                      )
                      .toList(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class _MoreWidget extends StatelessWidget {
  const _MoreWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButtonWidget(
          onPressed: () {
            context.showBottomSheet(
              child: AddMemberWidget(
                users: context
                        .read<AppService>()
                        .state
                        .user
                        ?.friends
                        .map((e) => e.user ?? const UserModel())
                        .toList() ??
                    [],
                onChanged: (value) {
                  context.read<GroupDetailCubit>().addMember(value);
                },
              ),
            );
          },
          icon: Assets.icons.profile.svg(
            width: 30.sp,
            height: 30.sp,
          ),
          title: GroupDetailConstants.addMembers.tr,
        ),
      ],
    );
  }
}
