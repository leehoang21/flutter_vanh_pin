import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/di/di.dart';
import 'cubit/notification_cubit.dart';
import 'notification_screen.dart';

@RoutePage()
class NotificationScreenProvider extends StatefulWidget {
  const NotificationScreenProvider({super.key});

  @override
  State<NotificationScreenProvider> createState() =>
      _NotificationScreenProviderState();
}

class _NotificationScreenProviderState
    extends State<NotificationScreenProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt.get<NotificationCubit>(),
        child: const NotificationScreen());
  }
}
