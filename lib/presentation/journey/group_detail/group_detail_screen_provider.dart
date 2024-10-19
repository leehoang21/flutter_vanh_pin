import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/common/extension/string_extension.dart';

import 'package:pinpin/data/models/group_model.dart';
import 'package:pinpin/presentation/journey/group_detail/group_detail_constants.dart';
import 'package:pinpin/presentation/widgets/button_widget/text_button_widget.dart';
import 'package:pinpin/presentation/widgets/scaffold_wdiget/scaffold_widget.dart';

import '../../../common/service/app_service.dart';
import '../../widgets/appbar_widget/appbar_widget.dart';
import '../../widgets/provider/provider_widget.dart';
import 'cubit/detail_group_cubit.dart';
import 'group_detail_screen.dart';

@RoutePage()
class GroupDetailScreenProvider extends StatelessWidget {
  const GroupDetailScreenProvider({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<GroupDetailCubit>(
      params: [groupModel],
      child: groupModel.author?.uId ==
                  context.read<AppService>().state.user?.uId ||
              (groupModel.memberIds ?? [])
                  .contains(context.read<AppService>().state.user?.uId)
          ? GroupDetailScreen(
              groupModel: groupModel,
            )
          : JoinGroupScreen(
              groupModel: groupModel,
            ),
    );
  }
}

class JoinGroupScreen extends StatelessWidget {
  const JoinGroupScreen({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appbar: AppBarWidget(
        title: groupModel.name,
      ),
      body: Column(
        children: [
          TextButtonWidget2(
            onPressed: () {},
            title: GroupDetailConstants.joinGroup.tr,
          ),
        ],
      ),
    );
  }
}
