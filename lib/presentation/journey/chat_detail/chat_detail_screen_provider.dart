import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/data/models/chat_model.dart';
import 'package:pinpin/data/models/user_model.dart';

import '../../../common/di/di.dart';
import 'cubit/chat_detail_cubit.dart';
import 'chat_detail_screen.dart';

@RoutePage()
class ChatDetailScreenProvider extends StatefulWidget {
  const ChatDetailScreenProvider({
    super.key,
    required this.model,
    required this.members,
  });
  final ChatModel model;
  final List<UserModel> members;

  @override
  State<ChatDetailScreenProvider> createState() =>
      _ChatDetailScreenProviderState();
}

class _ChatDetailScreenProviderState extends State<ChatDetailScreenProvider> {
  late final ChatDetailCubit _cubit;

  @override
  void initState() {
    _cubit = getIt.get<ChatDetailCubit>();
    _cubit.initState(widget.model, widget.members);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _cubit,
        child: ChatScreen(
          model: widget.model,
        ));
  }
}
