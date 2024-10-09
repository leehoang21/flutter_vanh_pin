import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pinpin/data/models/post_model.dart';
import '../../widgets/provider/provider_widget.dart';
import 'cubit/comment_cubit.dart';
import 'comment_screen.dart';

@RoutePage()
class CommentScreenProvider extends StatelessWidget {
  const CommentScreenProvider({super.key, required this.post});
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<CommentCubit>(
      params: [post],
      child: const CommentScreen(),
    );
  }
}
