import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/di/di.dart';
import 'cubit/create_post_cubit.dart';
import 'create_post_screen.dart';

@RoutePage()
class CreatePostScreenProvider extends StatefulWidget {
  const CreatePostScreenProvider({super.key});

  @override
  State<CreatePostScreenProvider> createState() =>
      _CreatePostScreenProviderState();
}

class _CreatePostScreenProviderState extends State<CreatePostScreenProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt.get<CreatePostCubit>(),
        child: const CreatePostScreen());
  }
}
