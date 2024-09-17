import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/data/models/group_model.dart';

import '../../../common/di/di.dart';
import 'cubit/create_post_cubit.dart';
import 'create_post_screen.dart';

@RoutePage()
class CreatePostScreenProvider extends StatefulWidget {
  const CreatePostScreenProvider({super.key, this.group});
  final GroupModel? group;

  @override
  State<CreatePostScreenProvider> createState() =>
      _CreatePostScreenProviderState();
}

class _CreatePostScreenProviderState extends State<CreatePostScreenProvider> {
  late final CreatePostCubit createPostCubit;

  @override
  void initState() {
    createPostCubit = getIt.get<CreatePostCubit>();
    createPostCubit.initState(widget.group);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => createPostCubit, child: const CreatePostScreen());
  }
}
