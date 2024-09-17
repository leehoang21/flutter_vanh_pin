import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickImageController {
  final imagePicker = ImagePicker();
  final bool isMultiple;

  PickImageController({this.isMultiple = true});

  Future gallery() async {
    if (isMultiple) {
      final images = await imagePicker.pickMultiImage();
      return images.map((e) => File(e.path)).toList();
    } else {
      final image = await imagePicker.pickImage(source: ImageSource.gallery);
      return image;
    }
  }

  Future<List<File>> camera() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    return [File(image!.path)];
  }
}
