import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:pinpin/presentation/widgets/pick_image/pick_image_controler.dart';

import '../../themes/themes.dart';
import 'pick_image_widget_constant.dart';

class PickImageWidget extends StatelessWidget {
  PickImageWidget({
    required this.onPressed,
    this.isMultiple = true,
    Key? key,
  }) : super(key: key);
  final Function(dynamic image) onPressed;
  final bool isMultiple;
  final PickImageController pickImageController = PickImageController();

  void show(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) {
        return PickImageWidget(onPressed: onPressed);
      },
    );
  }

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
