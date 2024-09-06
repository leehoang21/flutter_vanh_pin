import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/di/di.dart';
import 'cubit/group_cubit.dart';
import 'group_screen.dart';

@RoutePage()
class GroupScreenProvider extends StatefulWidget {
  const GroupScreenProvider({super.key});

  @override
  State<GroupScreenProvider> createState() => _GroupScreenProviderState();
}

class _GroupScreenProviderState extends State<GroupScreenProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt.get<GroupCubit>(),
        child: const GroupScreen());
  }
}
