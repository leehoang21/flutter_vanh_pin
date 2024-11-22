import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:encrypt/encrypt.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/data/models/chat_model.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:pinpin/domain/repositories/user_repository.dart';

import '../../common/configs/default_environment.dart';
import '../../common/configs/firebase_config.dart';
import '../../common/configs/notification_config/notification_config.dart';
import '../../common/exception/app_error.dart';
import '../../common/service/app_service.dart';
import '../../common/service/key.dart';
import '../../domain/repositories/chat_reposotory.dart';
import '../../presentation/widgets/chat_view/chatview.dart';
import '../models/notification_model.dart';

@Injectable(as: ChatRepository)
class ChatRepositoryImpl extends ChatRepository {
  final FirebaseConfig config;
  final AppService appService;
  final UserRepository userRepository;
  final NotificationConfig notificationConfig;

  ChatRepositoryImpl(
    this.config,
    this.appService,
    this.userRepository,
    this.notificationConfig,
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
        data = data.copyWith(
          updatedAt: DateTime.now(),
        );
        final params = data.toJson();
        params.remove('createdAt');
        await _doc.doc(chatId).update(params);
        return Left(data);
      } else {
        final KeyApp keyApp = KeyApp();
        data = data.copyWith(
          createdAt: DateTime.now(),
          idKey: keyApp.gennerateKey.$1.base16,
        );
        final param = data.toJson();

        final key0 = keyApp.gennerateKey;
        for (final member in data.members) {
          await _sendKey(member, data.idKey ?? "", key0);
        }
        final result = await _doc.add(param);
        await _doc.doc(result.id).update({'uId': result.id});
        return Left(data.copyWith(uId: result.id));
      }
    } catch (e) {
      return Right(AppError(message: e.toString()));
    }
  }

  _sendKey(UserModel user, String chatId, (Key, IV) key0) async {
    final KeyApp keyApp = KeyApp();
    await keyApp.setKeyAes(
      key0.$1.base64,
      key0.$2.base64,
      chatId,
    );
    //
    final content = '${key0.$1.base64},,,${key0.$2.base64}';
    //
    await notificationConfig.sendMessenger(
      NotificationModel(
        type: NotificationType.keyChat,
        createdAt: DateTime.now(),
        author: appService.state.user,
        user: user,
        token: content,
        content: '',
        id: chatId,
      ),
    );
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
    required ChatModel model,
  }) async {
    if (config.auth.currentUser == null) return null;
    try {
      final data = memers.map((e) => e.toJson()).toList();
      await _doc.doc(model.uId).update({
        'memberIds': FieldValue.arrayRemove(data.map((e) => e['uId']).toList())
      });
      //send notification
      for (final i in memers) {
        KeyApp keyApp = KeyApp();
        final key = await keyApp.getKeyAes(model.idKey ?? '');
        await notificationConfig.sendMessenger(
          NotificationModel(
            type: NotificationType.removeGroupChatSuccess,
            createdAt: DateTime.now(),
            author: appService.state.user,
            user: i,
            token: '${key!.$1.base64},,,${key.$2.base64}',
            content: '',
            id: model.idKey,
          ),
        );
      }
      //
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }

  @override
  Future<AppError?> sendOrUpdateMessage({
    required Message data,
    String? id,
    required ChatModel model,
  }) async {
    if (config.auth.currentUser == null) return null;
    try {
      //
      KeyApp keyApp = KeyApp();

      final key = await keyApp.getKeyAes(model.idKey ?? '');
      final message = data.message;
      //
      data = data.copyWith(
          message: keyApp.encrypted(message, key!.$1.base64, key.$2.base64),
          replyMessage: data.replyMessage.copyWith(
            message: keyApp.encrypted(
              data.replyMessage.message,
              key.$1.base64,
              key.$2.base64,
            ),
          ));
      //
      if (!isNullEmpty(id)) {
        await _doc
            .doc(model.uId)
            .collection(DefaultEnvironment.message)
            .doc(id)
            .update(data.toJson());

        await _doc.doc(model.uId).update({
          'chatContent': data.message,
          'updatedAt': data.createdAt.toIso8601String(),
        });
      } else {
        final param = data.toJson();
        //
        for (final i in model.members) {
          if (i.uId != appService.state.user?.uId) {
            notificationConfig.sendMessenger(
              NotificationModel(
                type: NotificationType.message,
                createdAt: DateTime.now(),
                author: appService.state.user,
                user: i,
                content: data.messageType == MessageType.text
                    ? message
                    : "${appService.state.user!.userName}${'sent photo'.tr}",
              ),
            );
          }
        }
        //
        final result = await _doc
            .doc(model.uId)
            .collection(DefaultEnvironment.message)
            .add(param);
        await _doc
            .doc(model.uId)
            .collection(DefaultEnvironment.message)
            .doc(result.id)
            .update({'uId': result.id});
        await _doc.doc(model.uId).update({
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
    required ChatModel model,
  }) async {
    if (config.auth.currentUser == null) return null;
    try {
      final data = memers.map((e) => e.toJson()).toList();
      await _doc.doc(model.uId).update({
        'members': FieldValue.arrayUnion(data),
        'memberIds': FieldValue.arrayUnion(data.map((e) => e['uId']).toList()),
      });
      //send notification
      for (final i in memers) {
        KeyApp keyApp = KeyApp();
        final key = await keyApp.getKeyAes(model.idKey ?? '');
        await notificationConfig.sendMessenger(
          NotificationModel(
            type: NotificationType.addGroupChatSuccess,
            createdAt: DateTime.now(),
            author: appService.state.user,
            user: i,
            token: '${key!.$1.base64},,,${key.$2.base64}',
            content: '',
            id: model.idKey,
          ),
        );
      }
      //
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
