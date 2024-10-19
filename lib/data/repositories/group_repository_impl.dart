import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/data/models/group_model.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:pinpin/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';
import '../../common/configs/default_environment.dart';
import '../../common/configs/firebase_config.dart';
import '../../common/exception/app_error.dart';
import '../../domain/repositories/group_repository.dart';

@Injectable(as: GroupRepository)
class GroupRepositoryImpl extends GroupRepository {
  final FirebaseConfig config;
  final AppService appService;
  final UserRepository userRepository;
  GroupRepositoryImpl(
    this.config,
    this.appService,
    this.userRepository,
  );

  CollectionReference<Map<String, dynamic>> get _doc =>
      config.userDoc.collection(DefaultEnvironment.group);

  @override
  Future<AppError?> create({
    required GroupModel group,
  }) async {
    if (config.auth.currentUser == null) return null;
    try {
      final param = group.toJson();
      final result = await _doc.add(param);
      final user = await userRepository.get();
      userRepository.update(user!.copyWith(
        groupIds: [...user.groupIds, result.id],
      ));
      //
      await _doc.doc(result.id).update({'uId': result.id});
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }

  @override
  Stream<Either<List<GroupModel>, AppError>> get(String authorId) {
    final result = _doc
        .where('author.uId', isEqualTo: authorId)
        .snapshots()
        .map<Either<List<GroupModel>, AppError>>((event) {
      try {
        final list =
            event.docs.map((e) => GroupModel.fromJson(e.data())).toList();
        return Left(list);
      } catch (e) {
        return Right(AppError(message: e.toString()));
      }
    });
    return result;
  }

  @override
  Stream<Either<List<GroupModel>, AppError>> getUnsubscribe(String authorId) {
    final result = _doc
        .where('author.uId', isNotEqualTo: authorId)
        .snapshots()
        .map<Either<List<GroupModel>, AppError>>((event) {
      try {
        final list =
            event.docs.map((e) => GroupModel.fromJson(e.data())).toList();
        return Left(list);
      } catch (e) {
        return Right(AppError(message: e.toString()));
      }
    });
    return result;
  }

  @override
  Stream<Either<GroupModel, AppError>> getDetail(String id) {
    final result = _doc
        .where('memberIds', arrayContains: id)
        .snapshots()
        .map<Either<GroupModel, AppError>>((event) {
      try {
        final list =
            event.docs.map((e) => GroupModel.fromJson(e.data())).toList();
        if (list.isEmpty) return Right(AppError(message: 'Group not found'));
        return Left(list.first);
      } catch (e) {
        return Right(AppError(message: e.toString()));
      }
    });
    return result;
  }

  @override
  Future<AppError?> addMembers(UserModel user, String id) async {
    try {
      await _doc.doc(id).update({
        'members': FieldValue.arrayUnion([user.toJson()]),
        'memberIds': FieldValue.arrayUnion([user.uId]),
      });
      return null;
    } catch (e) {
      return AppError(message: e.toString());
    }
  }

  @override
  Future<AppError?> delete(String id) async {
    try {
      await _doc.doc(id).delete();
      return null;
    } catch (e) {
      return AppError(message: e.toString());
    }
  }

  @override
  Future<AppError?> leave(UserModel user, String id) async {
    try {
      await _doc.doc(id).update({
        'members': FieldValue.arrayRemove([user.toJson()]),
        'memberIds': FieldValue.arrayRemove([user.uId]),
      });
      return null;
    } catch (e) {
      return AppError(message: e.toString());
    }
  }
}
