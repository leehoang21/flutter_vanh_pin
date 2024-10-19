import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../widgets/provider/provider_widget.dart';
import 'cubit/friend_cubit.dart';
import 'friend_screen.dart';

@RoutePage()
class FriendScreenProvider extends StatelessWidget {
  const FriendScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ProviderWidget<FriendCubit>(
      params: [],
      child: FriendScreen(),
    );
  }
}
