import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pinpin/data/models/chat_model.dart';
import 'package:pinpin/data/models/user_model.dart';
import '../../widgets/provider/provider_widget.dart';
import 'cubit/chat_detail_cubit.dart';
import 'chat_detail_screen.dart';

@RoutePage()
class ChatDetailScreenProvider extends StatelessWidget {
  final ChatModel model;
  final List<UserModel> members;

  const ChatDetailScreenProvider(
      {super.key, required this.model, required this.members});

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ChatDetailCubit>(
      params: [model, members],
      child: ChatScreen(model: model),
    );
  }
}
