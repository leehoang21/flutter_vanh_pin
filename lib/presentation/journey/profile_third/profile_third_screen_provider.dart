import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:pinpin/data/models/user_model.dart';

import '../../widgets/provider/provider_widget.dart';
import 'cubit/profile_third_cubit.dart';
import 'profile_third_screen.dart';

@RoutePage()
class ProfileThirdScreenProvider extends StatelessWidget {
  const ProfileThirdScreenProvider({super.key, required this.user});
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ProfileThirdCubit>(
      params: [user?.uId ?? ''],
      child: const ProfileThirdScreen(),
    );
  }
}
