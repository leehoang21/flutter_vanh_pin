import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../common/exception/app_error.dart';
import '../repositories/storage_repository.dart';

@injectable
class StorageUseCase {
  final StorageRepository storageRepository;

  StorageUseCase(this.storageRepository);

  Future<Either<String, AppError>> put({
    required File imageToUpload,
    required String imagePathStorage,
  }) async {
    final error = await storageRepository.put(
      data: imageToUpload,
      pathStorage: imagePathStorage,
    );
    if (error != null) {
      return Right(error);
    } else {
      return downUrl(imagePathStorage: imagePathStorage);
    }
  }

  Future<Either<String, AppError>> downUrl({
    required String imagePathStorage,
  }) async {
    return storageRepository.downloadUrl(
      pathStorage: imagePathStorage,
    );
  }
}
