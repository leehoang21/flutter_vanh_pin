import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_pin/common/constants/string_constants.dart';
import 'package:injectable/injectable.dart';
import '../../common/configs/firebase_config.dart';
import '../../common/exception/app_error.dart';
import '../../domain/repositories/storage_repository.dart';

@Injectable(as: StorageRepository)
class StorageRepositoryImpl extends StorageRepository {
  final FirebaseConfig config;

  String get _uId => config.auth.currentUser?.uid ?? '';

  StorageRepositoryImpl(this.config);
  @override
  Future<AppError?> put({
    required File data,
    required String pathStorage,
  }) async {
    try {
      final Reference storageRef =
          config.userStorage.child('$_uId/$pathStorage');
      TaskSnapshot taskSnapshot = await storageRef.putFile(data);
      if (taskSnapshot.state == TaskState.success) {
        return null;
      }
      return AppError(message: StringConstants.uploadFailed);
    } catch (e) {
      return AppError(message: e.toString());
    }
  }

  @override
  Future<Either<String, AppError>> downloadUrl({
    required String pathStorage,
  }) async {
    try {
      return Left(await config.userStorage
          .child(_uId)
          .child(pathStorage)
          .getDownloadURL());
    } catch (e) {
      return Right(AppError(message: e.toString()));
    }
  }
}
