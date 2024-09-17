import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/presentation/journey/home/home_constants.dart';
import 'package:pinpin/presentation/journey/my_page/cubit/my_page_cubit.dart';
import 'package:pinpin/presentation/themes/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../routers/app_router.dart';

class CreatePostMyPageWidget extends StatelessWidget {
  const CreatePostMyPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: InkWell(
        onTap: () async {
          await context.pushRoute(CreatePostRoute());
          context.read<MyPageCubit>().init();
        },
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cellphones.com.vn/sforum/wp-content/uploads/2024/02/anh-thien-nhien-1.jpg'),
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
