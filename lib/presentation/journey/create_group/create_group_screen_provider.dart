import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../widgets/provider/provider_widget.dart';
import 'cubit/create_group_cubit.dart';
import 'create_group_screen.dart';

@RoutePage()
class CreateGroupScreenProvider extends StatelessWidget {
  const CreateGroupScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderWidget<CreateGroupCubit>(
      params: [],
      child: CreateGroupScreen(),
    );
  }
}
