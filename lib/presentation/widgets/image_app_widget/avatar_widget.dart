import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pinpin/common/assets/assets.gen.dart';
import 'package:pinpin/common/utils/app_utils.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    required this.path,
    this.size,
  });
  final String? path;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircleAvatar(
        backgroundImage: _image,
      ),
    );
  }

  ImageProvider get _image {
    if (isNullEmpty(path)) {
      return Assets.images.defaultAvatar.image(width: size, height: size).image;
    } else if (path!.contains('asset'.toUpperCase())) {
      return AssetImage(path!);
    } else if (path.toString().contains('http://') ||
        path.toString().contains('https://')) {
      return NetworkImage(path!);
    } else {
      return FileImage(File(path!));
    }
  }
}
