import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/common/extension/string_extension.dart';

import 'package:pinpin/presentation/journey/create_post/widget/inovoice_photos_widget.dart';
import 'package:pinpin/presentation/widgets/button_widget/text_button_widget.dart';
import 'package:pinpin/presentation/widgets/text_field_widget/text_field_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/appbar_widget/appbar_widget.dart';
import '../../widgets/scaffold_wdiget/scaffold_widget.dart';
import 'create_post_constants.dart';
import 'cubit/create_post_cubit.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appbar: AppBarWidget(
        title: CreatePostConstants.title.tr,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CreatePostCubit>().onInit();
        },
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            TextFieldWidget(
              controller: _contentController,
              maxLines: 6,
              hintText: CreatePostConstants.hintContent.tr,
            ),
            const InvoicePhotosWidget(),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: TextButtonWidget(
                onPressed: () {
                  _post(_contentController.text);
                },
                title: CreatePostConstants.post.tr,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _post(String content) {
    context.read<CreatePostCubit>().createPost(content);
  }
}
