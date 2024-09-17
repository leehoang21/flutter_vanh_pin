import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/data/models/group_model.dart';

import '../../../common/di/di.dart';
import 'cubit/detail_group_cubit.dart';
import 'group_detail_screen.dart';

@RoutePage()
class GroupDetailScreenProvider extends StatefulWidget {
  const GroupDetailScreenProvider({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  State<GroupDetailScreenProvider> createState() =>
      _GroupDetailScreenProviderState();
}

class _GroupDetailScreenProviderState extends State<GroupDetailScreenProvider> {
  late final GroupDetailCubit cubit;

  @override
  void initState() {
    cubit = getIt.get<GroupDetailCubit>();
    cubit.initState(widget.groupModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: GroupDetailScreen(
        groupModel: widget.groupModel,
      ),
    );
  }
}
