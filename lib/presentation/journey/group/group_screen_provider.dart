import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../widgets/provider/provider_widget.dart';
import 'cubit/group_cubit.dart';
import 'group_screen.dart';

@RoutePage()
class GroupScreenProvider extends StatelessWidget {
  const GroupScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderWidget<GroupCubit>(
      params: [],
      child: GroupScreen(),
    );
  }
}
