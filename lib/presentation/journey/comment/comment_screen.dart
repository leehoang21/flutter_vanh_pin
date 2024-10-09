import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/presentation/widgets/card_widget/comment_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/presentation/widgets/text_field_widget/text_field_widget.dart';
import 'cubit/comment_cubit.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 12.h,
                ),
                BlocBuilder<CommentCubit, CommentState>(
                  builder: (context, state) {
                    return Column(
                        children: state.comments
                            .map(
                              (e) => CommentCard(
                                model: e,
                              ),
                            )
                            .toList());
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: TextFieldWidget(
              controller: _controller,
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  context.read<CommentCubit>().send(_controller.text);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
