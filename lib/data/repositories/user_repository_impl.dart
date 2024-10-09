import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinpin/common/constants/string_constants.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/data/mapper/auth_mapper.dart';

import 'package:injectable/injectable.dart';
import '../../common/configs/default_environment.dart';
import '../../common/configs/firebase_config.dart';
import '../../common/exception/app_error.dart';
import '../../domain/repositories/friend_repository.dart';
import '../../domain/repositories/storage_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/friend_model.dart';
import '../models/user_model.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final FirebaseConfig config;
  final AppService appService;
  final FriendRepository friendRepository;

  final StorageRepository storageRepository;
  UserRepositoryImpl(
    this.config,
    this.storageRepository,
    this.appService,
    this.friendRepository,
  ) : super();

  DocumentReference<Map<String, dynamic>> get _doc => config.userDoc
      .collection(config.auth.currentUser?.uid ?? '')
      .doc(DefaultEnvironment.user);

  CollectionReference<Map<String, dynamic>> get _users =>
      config.userDoc.collection(DefaultEnvironment.user);

  @override
  Future<AppError?> create(UserModel data) async {
    if (config.auth.currentUser == null) return null;
    try {
      final bool exists = await exits();
      if (exists) {
        return AppError(message: StringConstants.userAlreadyExists);
      } else {
        await _doc.set(data.toJson());
        //
        final user = UserModel(
          avatar: data.avatar,
          userName: data.userName,
          uId: config.auth.currentUser?.uid,
          background: data.background,
        );
        await _users.doc(config.auth.currentUser?.uid).set(user.toJson());
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
        final param = {
          'phoneNumber': data.phoneNumber,
          'userName': data.userName,
          'address': data.address,
          'education': data.education,
          'job': data.job,
        };
        if (isNullEmpty(data.avatar)) {
          param['avatar'] = data.avatar;
        }

        await _doc.update(param);
        appService.setUser(appService.state.user!.copyWith(
          phoneNumber: data.phoneNumber,
          userName: data.userName,
          avatar: isNullEmpty(data.avatar) ? null : data.avatar,
          address: data.address,
          education: data.education,
          job: data.job,
        ));
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
  Future<UserModel?> get({
    String? id,
  }) async {
    try {
      if (!isNullEmpty(id)) {
        final d = config.userDoc.collection(id!).doc(DefaultEnvironment.user);
        final result = await d.get();
        if (result.exists) {
          return UserModel.fromDocument(result);
        }
        return null;
      }
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
      final friends = await friendRepository.get(FriendStatus.all);

      return user.copyWith(friends: friends);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<UserModel>> getAll() async {
    try {
      final result = await _users.get();
      final users = result.docs.map((e) => UserModel.fromDocument(e)).toList();
      return users;
    } catch (e) {
      return [];
    }
  }
}
