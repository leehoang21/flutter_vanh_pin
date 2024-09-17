import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinpin/common/constants/string_constants.dart';
import 'package:pinpin/data/mapper/auth_mapper.dart';

import 'package:injectable/injectable.dart';
import '../../common/configs/default_environment.dart';
import '../../common/configs/firebase_config.dart';
import '../../common/exception/app_error.dart';
import '../../domain/repositories/storage_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/user_model.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final FirebaseConfig config;

  final StorageRepository storageRepository;
  UserRepositoryImpl(
    this.config,
    this.storageRepository,
  ) : super();

  DocumentReference<Map<String, dynamic>> get _doc => config.userDoc
      .collection(config.auth.currentUser?.uid ?? '')
      .doc(DefaultEnvironment.user);

  @override
  Future<AppError?> create(UserModel data) async {
    if (config.auth.currentUser == null) return null;
    try {
      final bool exists = await exits();
      if (exists) {
        return AppError(message: StringConstants.userAlreadyExists);
      } else {
        await _doc.set(data.toJson());
      }
      return null;
    } catch (e) {
      return AppError(message: e.toString());
    }
  }

  @override
  Future<AppError?> update(UserModel data) async {
    if (config.auth.currentUser == null) return null;
    try {
      final bool exists = await exits();
      if (exists) {
        await _doc.update(data.toJson());
      } else {
        return AppError(message: StringConstants.userNotExists);
      }
      return null;
    } catch (e) {
      return AppError(message: e.toString());
    }
  }

  @override
  Future<bool> exits() async {
    try {
      final result = await _doc.get();
      return result.exists;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<UserModel?> get() async {
    try {
      if (config.auth.currentUser == null) return null;
      final bool exists = await exits();
      if (!exists) {
        return AuthMapper.convertUserCredentialToUserModel(
          config.auth.currentUser!,
        );
      }
      final result = await _doc.get();
      final user = UserModel.fromDocument(
        result,
      );
      return user;
    } catch (e) {
      return null;
    }
  }
}
