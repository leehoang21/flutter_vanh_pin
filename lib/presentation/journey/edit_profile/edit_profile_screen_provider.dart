import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../widgets/provider/provider_widget.dart';
import 'cubit/edit_profile_cubit.dart';
import 'edit_profile_screen.dart';

@RoutePage()
class EditProfileScreenProvider extends StatelessWidget {
  const EditProfileScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ProviderWidget<EditProfileCubit>(
      params: [],
      child: EditProfileScreen(),
    );
  }
}
