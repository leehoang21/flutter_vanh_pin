import 'package:pinpin/common/assets/assets.gen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainConstants {
  static final floatingActionButtonIconSize = 52.sp;

  static const screenAnimatingDuration = Duration(milliseconds: 300);

  static final List<Map<String, dynamic>> bottomIconsData = [
    {
      "iconPath": Assets.icons.home.path,
      "label": 'Home',
    },
    {
      "iconPath": Assets.icons.groups.path,
      "label": 'Groups',
    },
    {
      "iconPath": Assets.icons.notification.path,
      "label": 'Notifications',
    },
    {
      "iconPath": Assets.icons.profile.path,
      "label": 'My page',
    },
  ];
}
