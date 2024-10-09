import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/common/assets/assets.gen.dart';
import 'package:pinpin/common/di/di.dart';
import 'package:pinpin/common/extension/show_extension.dart';
import 'package:pinpin/common/extension/string_extension.dart';

import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/domain/use_cases/post_use_case.dart';
import 'package:pinpin/presentation/journey/comment/comment_screen_provider.dart';
import 'package:pinpin/presentation/routers/app_router.dart';
import 'package:pinpin/presentation/themes/themes.dart';
import 'package:pinpin/presentation/widgets/button_widget/icon_button_widget.dart';
import 'package:pinpin/presentation/widgets/card_widget/card_custom.dart';
import 'package:pinpin/presentation/widgets/card_widget/post_card_controller.dart';
import 'package:pinpin/presentation/widgets/card_widget/show.dart';
import 'package:pinpin/presentation/widgets/chat_view/src/widgets/emoji_row.dart';
import 'package:pinpin/presentation/widgets/image_app_widget/image_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../data/models/post_model.dart';
import 'share_widget.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.model,
    this.padding,
  });
  final PostModel model;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    if (model.share != null) {
      return Padding(
        padding: padding ??
            EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              bottom: 10.h,
            ),
        child: _postDetail(
          context,
          model.share!,
          _AuthorCard(
            model: model,
            isMore: true,
          ),
          false,
        ),
      );
    }
    return Padding(
      padding: padding ??
          EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            bottom: 10.h,
          ),
      child: _postDetail(context, model, null, true),
    );
  }

  CardCustom _postDetail(
      BuildContext context, PostModel post, Widget? appbar, bool isMore) {
    return CardCustom(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              appbar ?? const SizedBox(),
              appbar == null ? const SizedBox() : const Divider(),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: appbar == null ? 0 : 10.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _AuthorCard(
                  model: model,
                  isMore: isMore,
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
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Like(
                model: model,
              ),
              IconPostButtonWidget(
                title: model.commentCount.toString(),
                icon: Assets.icons.message.svg(
                  width: 20.sp,
                  height: 20.sp,
                ),
                onPressed: () {
                  context.showBottomSheet(
                    child: CommentScreenProvider(post: model),
                  );
                },
              ),
              IconPostButtonWidget(
                title: model.shareCount.toString(),
                icon: Assets.icons.share.svg(
                  width: 20.sp,
                  height: 20.sp,
                ),
                onPressed: () {
                  context.showBottomSheet(
                    child: ShareWidget(post: model),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox _image() {
    return isNullEmptyList(model.images)
        ? const SizedBox()
        : SizedBox(
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

class Like extends StatelessWidget {
  const Like({
    super.key,
    required this.model,
  });
  final PostModel model;

  @override
  Widget build(BuildContext context) {
    return IconPostButtonWidget(
      title: model.emojis?.length.toString(),
      icon: (model.emojis ?? []).where(
        (element) {
          return element.author?.uId ==
              context.read<AppService>().state.user?.uId;
        },
      ).isNotEmpty
          ? Assets.icons.likeIcon.svg(
              width: 20.sp,
              height: 20.sp,
              colorFilter: const ColorFilter.mode(
                AppColor.blue,
                BlendMode.srcIn,
              ),
            )
          : Assets.icons.likeIcon.svg(
              width: 20.sp,
              height: 20.sp,
            ),
      onPressed: () {
        final list = (model.emojis ?? []).where(
          (element) {
            return element.author?.uId ==
                context.read<AppService>().state.user?.uId;
          },
        );
        list.isNotEmpty
            ? _removeLike(list.first.emoji ?? '')
            : _showPopup(context);
      },
    );
  }

  _removeLike(String emoji) async {
    final PostUseCase postUseCase = await getIt.getAsync<PostUseCase>();

    try {
      await postUseCase.like(
          emoji: emoji, postId: model.uId ?? '', isLike: true);
    } on Exception catch (e) {
      logger(e);
    }
  }

  _showPopup(BuildContext context) {
    final ShowPopup showPopup = ShowPopup(context: context);
    showPopup.createPopup(
      Container(
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10000),
          boxShadow: [
            BoxShadow(
              color: AppColor.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
          color: AppColor.white,
        ),
        child: SizedBox(
          height: 35.h,
          child: EmojiRow(
            onTapMore: () {
              showPopup.close();
            },
            onEmojiTap: (emoji) async {
              final PostUseCase postUseCase =
                  await getIt.getAsync<PostUseCase>();

              try {
                await postUseCase.like(
                    emoji: emoji, postId: model.uId ?? '', isLike: false);
              } on Exception catch (e) {
                logger(e);
              } finally {
                showPopup.close();
              }
            },
          ),
        ),
      ),
    );
  }
}

class _AuthorCard extends StatelessWidget {
  const _AuthorCard({required this.model, required this.isMore});
  final PostModel model;
  final bool isMore;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _avatar(context),
        SizedBox(
          width: 10.w,
        ),
        _content(),
        const Spacer(),
        if (model.author.uId == context.read<AppService>().state.user?.uId &&
            isMore)
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              context.showBottomSheet(
                child: MorePost(model: model),
              );
            },
          ),
      ],
    );
  }

  Column _content() {
    return model.group != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.group?.name ?? '',
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

  Widget _avatar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (model.group != null) {
          context.pushRoute(GroupDetailRoute(groupModel: model.group!));
        } else {
          if (model.author.uId == context.read<AppService>().state.user?.uId) {
            context.pushRoute(const MyPageRoute());
          } else {
            context.pushRoute(ProfileThirdRoute(
              user: model.author,
            ));
          }
        }
      },
      child: model.group != null
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
                        image: CachedNetworkImageProvider(
                            model.group?.avatar ?? ''),
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
            ),
    );
  }
}

class MorePost extends StatelessWidget {
  const MorePost({super.key, required this.model});
  final PostModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 20.h,
        ),
        Text(
          "More post".tr,
          style: ThemeText.body1,
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButtonWidget(
              size: 40.sp,
              icon: const Icon(Icons.edit),
              onPressed: () async {
                await context.pushRoute(CreatePostRoute(
                  post: model,
                ));
                context.popRoute();
              },
              title: 'Edit'.tr,
            ),
            IconButtonWidget(
              icon: Assets.icons.trash.svg(
                width: 35.sp,
                height: 35.sp,
              ),
              onPressed: () async {
                final PostCardController postCardController =
                    await getIt.getAsync<PostCardController>();
                await postCardController.delete(model.uId ?? '');
                context.popRoute();
              },
              title: 'Delete'.tr,
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
