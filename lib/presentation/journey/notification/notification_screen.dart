import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/data/models/notification_model.dart';
import 'package:pinpin/presentation/journey/notification/cubit/notification_cubit.dart';
import 'package:pinpin/presentation/journey/notification/notification_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/presentation/widgets/button_widget/text_button_widget.dart';
import 'package:pinpin/presentation/widgets/image_app_widget/avatar_widget.dart';
import 'package:pinpin/presentation/widgets/scaffold_wdiget/scaffold_widget.dart';
import '../../themes/themes.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      padding: EdgeInsets.zero,
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
        ),
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text(NotificationConstants.title, style: ThemeText.headline6),
          SizedBox(
            height: 10.h,
          ),
          for (int i = 0;
              i < context.watch<AppService>().state.notifications.length;
              i++)
            _ItemNotification(
              index: i,
            )
        ],
      ),
    );
  }
}

class NotificationTitile extends StatelessWidget {
  const NotificationTitile({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: (_) {
              context.read<AppService>().deleteNotification(
                  context.read<AppService>().state.notifications[index]);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete'.tr,
          ),
        ],
      ),
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: (_) {
              context.read<AppService>().deleteNotification(
                  context.read<AppService>().state.notifications[index]);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete'.tr,
          ),
        ],
      ),
      child: _ItemNotification(index: index),
    );
  }
}

class _ItemNotification extends StatefulWidget {
  const _ItemNotification({required this.index});
  final int index;

  @override
  State<_ItemNotification> createState() => _ItemNotificationState();
}

class _ItemNotificationState extends State<_ItemNotification> {
  @override
  Widget build(BuildContext context) {
    final data = context.watch<AppService>().state.notifications[widget.index];
    return GestureDetector(
      onTap: () {
        context.read<AppService>().read(data);
        setState(() {});
      },
      child: Container(
        color: data.isRead
            ? AppColor.backgroundColor
            : AppColor.grey.withOpacity(0.1),
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(10.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AvatarWidget(
              path: data.author?.avatar ?? '',
              size: 40.sp,
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(child: _content(data)),
            SizedBox(
              width: 10.w,
            ),
            !isNullEmpty(data.type?.titleAction)
                ? TextButtonWidget2(
                    onPressed: () {
                      if (data.type == NotificationType.addFriend) {
                        context
                            .read<NotificationCubit>()
                            .acceptAddFriend(data.author);
                      }
                    },
                    title: data.type?.titleAction ?? '')
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Column _content(NotificationModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: data.type?.title ?? '',
            style: ThemeText.style14Medium,
            children: [
              TextSpan(
                text: ' ${data.notification}',
                style: ThemeText.caption,
              ),
            ],
          ),
        ),
        Text(
          timeago.format(data.time ?? DateTime.now(), locale: 'en_short'),
          style: ThemeText.style12Regular.copyWith(
            color: AppColor.grey,
          ),
        ),
      ],
    );
  }
}
