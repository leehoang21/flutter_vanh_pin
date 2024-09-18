import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/di/di.dart';
import 'cubit/chat_cubit.dart';
import 'chat_screen.dart';

@RoutePage()
class ChatScreenProvider extends StatefulWidget {
  const ChatScreenProvider({super.key});

  @override
  State<ChatScreenProvider> createState() => _ChatScreenProviderState();
}

class _ChatScreenProviderState extends State<ChatScreenProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt.get<ChatCubit>(), child: const ChatScreen());
  }
}
