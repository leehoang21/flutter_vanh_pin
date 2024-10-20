import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/presentation/journey/home/home_constants.dart';
import 'package:pinpin/presentation/themes/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/presentation/widgets/image_app_widget/avatar_widget.dart';

import '../../../routers/app_router.dart';

class CreatePostWidget extends StatelessWidget {
  const CreatePostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: InkWell(
        onTap: () {
          context.pushRoute(CreatePostRoute());
        },
        child: Row(
          children: [
            AvatarWidget(
                path: context.watch<AppService>().state.user?.avatar ?? ""),
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
                  HomeConstants.createPostTitle.tr,
                  style: ThemeText.caption,
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
        ),
      ),
    );
  }
}
