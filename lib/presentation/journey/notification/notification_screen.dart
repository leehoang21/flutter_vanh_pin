import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              i < context.watch<NotificationCubit>().state.notifications.length;
              i++)
            _ItemNotification(
              index: i,
            )
        ],
      ),
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
    final data =
        context.watch<NotificationCubit>().state.notifications[widget.index];
    return GestureDetector(
      onTap: () {
        if (data.type!.checkRead) {
          context.read<NotificationCubit>().read(data.id);
        }
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
            (!isNullEmpty(data.type?.titleAction) && !data.isRead)
                ? TextButtonWidget2(
                    onPressed: () {
                      context.read<NotificationCubit>().action(data);
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
        Text(
          ' ${data.notification}',
          style: ThemeText.style12Regular.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          timeago.format(data.createdAt ?? DateTime.now(), locale: 'en_short'),
          style: ThemeText.style12Regular.copyWith(
            color: AppColor.grey,
          ),
        ),
      ],
    );
  }
}
