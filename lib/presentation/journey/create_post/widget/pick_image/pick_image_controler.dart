import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickImageController {
  final imagePicker = ImagePicker();

  Future<List<File>> gallery() async {
    final images = await imagePicker.pickMultiImage();
    return images.map((e) => File(e.path)).toList();
  }

  Future<List<File>> camera() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    return [File(image!.path)];
  }
}
