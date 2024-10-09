// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pinpin/presentation/themes/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final Widget icon;
  final Color? buttonColor;
  final Color? borderColor;
  final double? size;
  final String? title;
  const IconButtonWidget({
    Key? key,
    required this.onPressed,
    this.buttonColor,
    this.title,
    this.borderColor,
    this.size,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RawMaterialButton(
          onPressed: onPressed,
          child: Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: borderColor ?? buttonColor ?? AppColor.primaryColor),
              color: buttonColor ?? AppColor.primaryColor,
            ),
            child: icon,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        if (title != null)
          Text(
            title!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 10.sp,
                  height: 1.07,
                  letterSpacing: 0.2,
                ),
          )
      ],
    );
  }
}

class IconPostButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final Widget icon;
  final Color? buttonColor;
  final String? title;
  const IconPostButtonWidget({
    Key? key,
    required this.onPressed,
    this.buttonColor,
    this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 24.sp,
            height: 24.sp,
            child: icon,
          ),
          SizedBox(
            width: 2.w,
          ),
          if (title != null)
            Text(
              title!,
              style: ThemeText.body2.copyWith(
                fontSize: 10.sp,
              ),
            )
        ],
      ),
    );
  }
}
