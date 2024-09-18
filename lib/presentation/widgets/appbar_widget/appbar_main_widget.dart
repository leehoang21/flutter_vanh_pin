// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../presentation/themes/themes.dart';
import 'appbar_constants.dart';

class AppBarMainWidget extends StatelessWidget implements PreferredSize {
  final String? title;
  final VoidCallback? onSearch;
  final Widget? traiiling;
  final VoidCallback? onCreate;
  const AppBarMainWidget({
    Key? key,
    this.title,
    this.onSearch,
    this.onCreate,
    this.traiiling,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Text(
                title ?? '',
                style: ThemeText.subtitle1.copyWith(
                    fontWeight: FontWeight.bold, color: AppColor.black),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            traiiling ?? const SizedBox(),
            onCreate == null
                ? const SizedBox()
                : IconButton(
                    onPressed: onCreate,
                    icon: const Icon(Icons.add_circle_outline,
                        color: Colors.black),
                  ),
            IconButton(
                onPressed: onSearch,
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget get child => Container();

  @override
  Size get preferredSize => AppbarConstants.appbarSize;
}
