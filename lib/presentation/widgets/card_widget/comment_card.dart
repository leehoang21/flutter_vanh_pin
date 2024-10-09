import 'package:flutter/material.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/data/models/comment_model.dart';
import 'package:pinpin/presentation/themes/themes.dart';
import 'package:pinpin/presentation/widgets/card_widget/card_custom.dart';
import 'package:pinpin/presentation/widgets/image_app_widget/avatar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
    required this.model,
    this.padding,
  });
  final CommentModel model;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.only(
            left: 10.w,
            right: 10.w,
            bottom: 10.h,
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AvatarWidget(
            path: model.author.avatar,
            size: 40.sp,
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              children: [
                CardCustom(
                  padding: EdgeInsets.all(5.w),
                  width: 1.sw,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.author.userName ?? '',
                        textAlign: TextAlign.start,
                        style: ThemeText.style12Regular.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        model.content,
                        textAlign: TextAlign.start,
                        style: ThemeText.style12Regular,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      timeago.format(model.time),
                      textAlign: TextAlign.start,
                      style: ThemeText.style12Regular,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      'Like'.tr,
                      textAlign: TextAlign.start,
                      style: ThemeText.style12Regular,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
