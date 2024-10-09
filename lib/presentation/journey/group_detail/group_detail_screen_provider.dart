import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:pinpin/data/models/group_model.dart';

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
      child: GroupDetailScreen(
        groupModel: groupModel,
      ),
    );
  }
}
