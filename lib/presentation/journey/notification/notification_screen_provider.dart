import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../widgets/provider/provider_widget.dart';
import 'cubit/notification_cubit.dart';
import 'notification_screen.dart';

@RoutePage()
class NotificationScreenProvider extends StatelessWidget {
  const NotificationScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderWidget<NotificationCubit>(
      params: [],
      child: NotificationScreen(),
    );
  }
}
