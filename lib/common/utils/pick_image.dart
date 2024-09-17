import 'dart:io';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:image_picker/image_picker.dart';

class PickImage {
  final ImagePicker _imagePicker = ImagePicker();

  Future<File?> pickImage({required ImageSource source}) async {
    try {
      XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      logger("pick image file$e");
    }
    return null;
  }

  Future<List<File>> multiImage() async {
    try {
      final List<XFile> files = await _imagePicker.pickMultiImage();
      final List<File> images = [];
      for (final file in files) {
        images.add(File(file.path));
      }
      return images;
    } catch (e) {
      logger("pick image file$e");
      return [];
    }
  }
}
