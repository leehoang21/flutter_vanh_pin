import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/di/di.dart';
import 'cubit/create_group_cubit.dart';
import 'create_group_screen.dart';

@RoutePage()
class CreateGroupScreenProvider extends StatefulWidget {
  const CreateGroupScreenProvider({super.key});

  @override
  State<CreateGroupScreenProvider> createState() =>
      _CreateGroupScreenProviderState();
}

class _CreateGroupScreenProviderState extends State<CreateGroupScreenProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt.get<CreateGroupCubit>(),
        child: const CreateGroupScreen());
  }
}
