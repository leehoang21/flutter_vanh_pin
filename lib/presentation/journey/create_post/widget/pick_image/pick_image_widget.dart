import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pin/presentation/journey/create_post/widget/pick_image/pick_image_controler.dart';

import '../../../../themes/themes.dart';
import 'pick_image_widget_constant.dart';

class PickImageWidget extends StatelessWidget {
  PickImageWidget({
    required this.onPressed,
    Key? key,
  }) : super(key: key);
  final Function(List<File>) onPressed;
  final PickImageController pickImageController = PickImageController();

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context, null);
        },
        child: Text(
          PickImageWidgetConstant.cancel,
          style: ThemeText.cancelButton,
        ),
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () async {
            Navigator.pop(context, null);
            final List<File> images = await pickImageController.gallery();
            onPressed(images);
          },
          child: Text(
            PickImageWidgetConstant.gallery,
            style: ThemeText.titleAction,
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () async {
            Navigator.pop(context, null);
            final List<File> images = await pickImageController.camera();
            onPressed(images);
          },
          child: Text(
            PickImageWidgetConstant.camera,
            style: ThemeText.titleAction,
          ),
        ),
      ],
    );
  }
}
