import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/common/constants/app_dimens.dart';
import 'package:pinpin/common/enums/app_enums.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/presentation/routers/app_router.dart';
import 'package:pinpin/presentation/widgets/appbar_widget/appbar_main_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/group_model.dart';
import '../../themes/themes.dart';
import '../../widgets/card_widget/post_card.dart';
import '../../widgets/scaffold_wdiget/scaffold_widget.dart';
import 'cubit/group_cubit.dart';
import 'group_constants.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appbar: AppBarMainWidget(
        title: GroupConstants.title.tr,
        onCreate: () {
          context.pushRoute(const CreateGroupRoute());
        },
      ),
      body: DefaultTabController(
        length: GroupConstants.tabs.length,
        child: Column(
          children: [
            SizedBox(
              height: AppDimens.height_44,
              child: TabBar(
                isScrollable: true,
                tabs: GroupConstants.tabs.map((title) {
                  return Tab(
                    text: title.tr,
                  );
                }).toList(),
                indicatorColor: AppColor.ebonyClay,
              ),
            ),
            const Expanded(
              child: TabBarView(children: [
                _PostWidget(),
                _GroupWidget(),
                _DiscoveryWidget(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostWidget extends StatelessWidget {
  const _PostWidget();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 20.h),
      children: context
          .watch<GroupCubit>()
          .state
          .posts
          .map(
            (e) => PostCard(
              model: e,
              padding: EdgeInsets.zero,
            ),
          )
          .toList(),
    );
  }
}

class _GroupWidget extends StatelessWidget {
  const _GroupWidget();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: context
          .watch<GroupCubit>()
          .state
          .myGroups
          .map(
            (e) => _GroupItemWidget(
              model: e,
            ),
          )
          .toList(),
    );
  }
}

class _DiscoveryWidget extends StatelessWidget {
  const _DiscoveryWidget();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: context
          .watch<GroupCubit>()
          .state
          .groups
          .map(
            (e) => _GroupItemWidget(
              model: e,
            ),
          )
          .toList(),
    );
  }
}

class _GroupItemWidget extends StatelessWidget {
  const _GroupItemWidget({required this.model});
  final GroupModel model;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (model.type == GroupType.public ||
            context.read<AppService>().state.user?.uId == model.author?.uId) {
          context.pushRoute(GroupDetailRoute(
            groupModel: model,
          ));
        } else {
          logger('message');
        }
      },
      leading: Container(
        width: 50.sp,
        height: 50.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          image: DecorationImage(
            image: Image.network(
              model.avatar ?? '',
              width: 50.sp,
              height: 50.sp,
            ).image,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(model.name ?? ''),
      subtitle: Text(model.members?.length.toString() ?? ''),
    );
  }
}
