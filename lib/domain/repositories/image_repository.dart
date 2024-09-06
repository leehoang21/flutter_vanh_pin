import '../../common/exception/app_error.dart';

abstract class ImageRepository {
  Future<AppError?> add({
    required List<String> images,
  });
}
