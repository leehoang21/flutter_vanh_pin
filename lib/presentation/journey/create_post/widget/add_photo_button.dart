import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../common/constants/layout_constants.dart';
import '../../../../common/assets/assets.gen.dart';
import '../../../themes/themes.dart';

class AddPhotoButton extends StatelessWidget {
  final Function() addPhoto;

  const AddPhotoButton({Key? key, required this.addPhoto}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: addPhoto,
      child: Container(
        width: 1.sw / 3 - 20.w,
        height: 200.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.fieldColor,
          borderRadius: BorderRadius.all(
            Radius.circular(LayoutConstants.roundedRadius),
          ),
        ),
        child: Assets.images.blackCamera.image(),
      ),
    );
  }
}
