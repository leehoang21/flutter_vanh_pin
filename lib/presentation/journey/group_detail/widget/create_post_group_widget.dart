import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/presentation/journey/group_detail/cubit/detail_group_cubit.dart';
import 'package:pinpin/presentation/themes/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/presentation/widgets/image_app_widget/avatar_widget.dart';

import '../../../routers/app_router.dart';
import '../group_detail_constants.dart';

class CreatePostGroupWidget extends StatelessWidget {
  const CreatePostGroupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushRoute(CreatePostRoute(
          group: context.read<GroupDetailCubit>().state.model,
        ));
      },
      child: Row(
        children: [
          const AvatarWidget(
            path:
                'https://cellphones.com.vn/sforum/wp-content/uploads/2024/02/anh-thien-nhien-1.jpg',
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(500),
              ),
              child: Text(
                GroupDetailConstants.createPostTitle.tr,
                style: ThemeText.caption,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
    );
  }
}
