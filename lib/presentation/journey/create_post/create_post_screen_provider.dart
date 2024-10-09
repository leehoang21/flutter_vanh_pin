import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pinpin/data/models/group_model.dart';
import 'package:pinpin/data/models/post_model.dart';
import '../../widgets/provider/provider_widget.dart';
import 'cubit/create_post_cubit.dart';
import 'create_post_screen.dart';

@RoutePage()
class CreatePostScreenProvider extends StatelessWidget {
  const CreatePostScreenProvider({super.key, this.group, this.post});
  final GroupModel? group;
  final PostModel? post;

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<CreatePostCubit>(
      params: [group, post],
      child: CreatePostScreen(
        model: post,
      ),
    );
  }
}
