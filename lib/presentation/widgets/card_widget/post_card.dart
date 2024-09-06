import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin/data/models/user_model.dart';
import 'package:flutter_pin/presentation/themes/themes.dart';
import 'package:flutter_pin/presentation/widgets/button_widget/icon_button_widget.dart';
import 'package:flutter_pin/presentation/widgets/card_widget/card_custom.dart';
import 'package:flutter_pin/presentation/widgets/image_app_widget/image_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../data/models/post_model.dart';

class PostCardModel {
  final UserModel author;
  final UserModel? group;
  final DateTime time;
  final String? image;
  final String? video;
  final String content;

  PostCardModel({
    required this.author,
    this.group,
    required this.time,
    this.image,
    this.video,
    required this.content,
  });
}

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.model,
  });
  final PostModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        bottom: 10.h,
      ),
      child: CardCustom(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AuthorCard(
              model: model,
            ),
            Text(
              model.content,
              textAlign: TextAlign.start,
              style: ThemeText.style12Regular,
            ),
            SizedBox(
              height: 10.h,
            ),
            _image(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconPostButtonWidget(
                  title: '1',
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
                IconPostButtonWidget(
                  title: '2',
                  icon: const Icon(Icons.comment),
                  onPressed: () {},
                ),
                IconPostButtonWidget(
                  icon: const Icon(Icons.share),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _image() {
    return SizedBox(
      height: 200.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (final image in model.images)
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: AppImageWidget(
                path: image,
                fit: BoxFit.cover,
                width: 1.sw / 3 - 10.w,
              ),
            ),
        ],
      ),
    );
  }
}

class _AuthorCard extends StatelessWidget {
  const _AuthorCard({required this.model});
  final PostModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _avatar(),
        SizedBox(
          width: 10.w,
        ),
        _content(),
      ],
    );
  }

  Column _content() {
    return model.group != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.group?.userName ?? '',
                style: ThemeText.style14Medium,
              ),
              RichText(
                text: TextSpan(
                  style: ThemeText.style12Regular.copyWith(
                    color: AppColor.grey,
                  ),
                  children: [
                    TextSpan(
                      text: model.author.userName ?? '',
                    ),
                    TextSpan(
                      text: ' • ',
                      style: TextStyle(
                        fontSize: 10.sp,
                      ),
                    ),
                    TextSpan(
                      text: timeago.format(model.time, locale: 'en_short'),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.author.userName ?? '',
                style: ThemeText.style14Medium,
              ),
              Text(
                timeago.format(model.time, locale: 'en_short'),
                style: ThemeText.style12Regular.copyWith(
                  color: AppColor.grey,
                ),
              ),
            ],
          );
  }

  Widget _avatar() {
    return model.group != null
        ? SizedBox(
            width: 38.sp,
            height: 38.sp,
            child: Stack(
              children: [
                Container(
                  width: 35.sp,
                  height: 35.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    image: DecorationImage(
                      image:
                          CachedNetworkImageProvider(model.group?.avatar ?? ''),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 15.sp,
                    height: 15.sp,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            model.author.avatar ?? ''),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            width: 40.sp,
            height: 40.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: CachedNetworkImageProvider(model.author.avatar ?? ''),
                fit: BoxFit.fill,
              ),
            ),
          );
  }
}
