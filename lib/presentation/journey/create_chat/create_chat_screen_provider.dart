import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../widgets/provider/provider_widget.dart';
import 'cubit/create_chat_cubit.dart';
import 'create_chat_screen.dart';

@RoutePage()
class CreateChatScreenProvider extends StatelessWidget {
  const CreateChatScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderWidget<CreateChatCubit>(
      params: [],
      child: CreateChatScreen(),
    );
  }
}
