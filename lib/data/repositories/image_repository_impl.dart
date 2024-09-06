import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../../common/configs/default_environment.dart';
import '../../common/configs/firebase_config.dart';
import '../../common/exception/app_error.dart';
import '../../domain/repositories/image_repository.dart';

@Injectable(as: ImageRepository)
class ImageRepositoryImpl extends ImageRepository {
  final FirebaseConfig config;
  ImageRepositoryImpl(
    this.config,
  );

  CollectionReference<Map<String, dynamic>> get _doc => config.userDoc
      .collection(config.auth.currentUser?.uid ?? '')
      .doc(DefaultEnvironment.customer)
      .collection(DefaultEnvironment.images);

  @override
  Future<AppError?> add({required List<String> images}) async {
    try {
      for (final url in images) {
        final param = {
          'url': url,
          'time': DateTime.now(),
        };
        await _doc.add(param);
      }
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }
}
