import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/di/di.dart';
import 'cubit/create_chat_cubit.dart';
import 'create_chat_screen.dart';

@RoutePage()
class CreateChatScreenProvider extends StatefulWidget {
  const CreateChatScreenProvider({super.key});

  @override
  State<CreateChatScreenProvider> createState() =>
      _CreateChatScreenProviderState();
}

class _CreateChatScreenProviderState extends State<CreateChatScreenProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt.get<CreateChatCubit>(),
        child: const CreateChatScreen());
  }
}
