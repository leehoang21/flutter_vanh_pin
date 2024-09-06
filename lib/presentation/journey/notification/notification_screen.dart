import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pin/presentation/journey/notification/notification_constants.dart';
import 'package:flutter_pin/presentation/widgets/loading_widget/loader_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../themes/themes.dart';
import 'cubit/notification_cubit.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Theme.of(context).appBarTheme.backgroundColor),
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<NotificationCubit>().onInit();
            },
            child: context.watch<NotificationCubit>().state.when(
                  loading: () => const LoaderWidget(),
                  loaded: (datas) => ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                    ),
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(NotificationConstants.title,
                          style: ThemeText.headline6),
                      SizedBox(
                        height: 10.h,
                      ),
                      for (final data in datas)
                        _ItemNotification(
                          data: data,
                        )
                    ],
                  ),
                ),
          ),
        ),
      ),
    );
  }
}

class _ItemNotification extends StatelessWidget {
  const _ItemNotification({required this.data});
  final NotificationData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 10.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _avatar(),
          SizedBox(
            width: 10.w,
          ),
          _content(),
        ],
      ),
    );
  }

  Column _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: data.author.userName ?? '',
            style: ThemeText.style14Medium,
            children: [
              TextSpan(
                text: ' ${data.title}',
                style: ThemeText.caption,
              ),
            ],
          ),
        ),
        Text(
          timeago.format(data.time, locale: 'vi'),
          style: ThemeText.style12Regular.copyWith(
            color: AppColor.grey,
          ),
        ),
      ],
    );
  }

  Widget _avatar() {
    return Container(
      width: 40.sp,
      height: 40.sp,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: CachedNetworkImageProvider(data.author.avatar ?? ''),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
