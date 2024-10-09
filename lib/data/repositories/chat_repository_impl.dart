import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/data/models/chat_model.dart';
import 'package:pinpin/data/models/user_model.dart';

import '../../common/configs/default_environment.dart';
import '../../common/configs/firebase_config.dart';
import '../../common/exception/app_error.dart';
import '../../domain/repositories/chat_reposotory.dart';
import '../../presentation/widgets/chat_view/chatview.dart';

@Injectable(as: ChatRepository)
class ChatRepositoryImpl extends ChatRepository {
  final FirebaseConfig config;

  ChatRepositoryImpl(
    this.config,
  );

  CollectionReference<Map<String, dynamic>> get _doc =>
      config.userDoc.collection(DefaultEnvironment.chat);

  @override
  Future<Either<ChatModel, AppError>> createOrUpdate({
    required ChatModel data,
    String? chatId,
  }) async {
    if (config.auth.currentUser == null) {
      return Right(AppError(message: 'User is null'));
    }
    try {
      if (!isNullEmpty(chatId)) {
        await _doc.doc(chatId).update(data.toJson());
        return Left(data);
      } else {
        final param = data.toJson();
        final result = await _doc.add(param);
        await _doc.doc(result.id).update({'uId': result.id});
        return Left(data.copyWith(uId: result.id));
      }
    } catch (e) {
      return Right(AppError(message: e.toString()));
    }
  }

  @override
  Future<AppError?> delete({required String id}) async {
    if (config.auth.currentUser == null) return null;
    try {
      await _doc.doc(id).delete();
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }

  @override
  Future<AppError?> deleteMessage({
    required String id,
    required String chatId,
  }) async {
    if (config.auth.currentUser == null) return null;
    try {
      await _doc
          .doc(chatId)
          .collection(DefaultEnvironment.message)
          .doc(id)
          .delete();
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }

  @override
  Stream<Either<List<ChatModel>, AppError>> get() {
    final result = _doc
        .where('memberIds', arrayContains: config.auth.currentUser!.uid)
        .orderBy('updatedAt', descending: false)
        .snapshots()
        .map<Either<List<ChatModel>, AppError>>((event) {
      try {
        final list = event.docs.map((e) => ChatModel.fromDocument(e)).toList();
        return Left(list);
      } catch (e) {
        return Right(AppError(message: e.toString()));
      }
    });
    return result;
  }

  @override
  Future<AppError?> removeMember({
    required List<UserModel> memers,
    required String chatId,
  }) async {
    if (config.auth.currentUser == null) return null;
    try {
      final data = memers.map((e) => e.toJson()).toList();
      await _doc.doc(chatId).update({'members': FieldValue.arrayRemove(data)});
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }

  @override
  Future<AppError?> sendOrUpdateMessage({
    required Message data,
    required String chatId,
    String? id,
  }) async {
    if (config.auth.currentUser == null) return null;
    try {
      if (!isNullEmpty(id)) {
        await _doc
            .doc(chatId)
            .collection(DefaultEnvironment.message)
            .doc(id)
            .update(data.toJson());
        await _doc.doc(chatId).update({
          'chatContent': data.message,
          'updatedAt': data.createdAt.toIso8601String(),
        });
      } else {
        final param = data.toJson();
        final result = await _doc
            .doc(chatId)
            .collection(DefaultEnvironment.message)
            .add(param);
        await _doc
            .doc(chatId)
            .collection(DefaultEnvironment.message)
            .doc(result.id)
            .update({'uId': result.id});
        await _doc.doc(chatId).update({
          'chatContent': data.message,
          'updatedAt': data.createdAt.toIso8601String(),
          'createdAt': data.createdAt.toIso8601String(),
        });
      }
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }

  @override
  Future<AppError?> addMember({
    required List<UserModel> memers,
    required String chatId,
  }) async {
    if (config.auth.currentUser == null) return null;
    try {
      final data = memers.map((e) => e.toJson()).toList();
      await _doc.doc(chatId).update({'members': FieldValue.arrayUnion(data)});
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }

  @override
  Stream<Either<List<Message>, AppError>> getMessages(
      {required String chatId}) {
    if (!isNullEmpty(chatId)) {
      final result = _doc
          .doc(chatId)
          .collection(DefaultEnvironment.message)
          .orderBy('createdAt', descending: false)
          .snapshots()
          .map<Either<List<Message>, AppError>>((event) {
        try {
          final list = event.docs.map((e) {
            final Map<String, dynamic> data = e.data();
            data['id'] = data['uId'];
            return Message.fromJson(data);
          }).toList();
          return Left(list);
        } catch (e) {
          return Right(AppError(message: e.toString()));
        }
      });
      return result;
    }
    return Stream.value(Right(AppError(message: 'ChatId is null')));
  }

  @override
  Future<String> isExitMessage({required List<UserModel> members}) async {
    final result = await _doc
        .where('members', isEqualTo: members.map((e) => e.toJson()).toList())
        .get();

    return result.docs.isNotEmpty ? result.docs.first.id : '';
  }
}
