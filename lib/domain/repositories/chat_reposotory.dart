import 'package:either_dart/either.dart';
import 'package:pinpin/data/models/chat_model.dart';
import 'package:pinpin/data/models/user_model.dart';

import '../../common/exception/app_error.dart';
import '../../presentation/widgets/chat_view/chatview.dart';

abstract class ChatRepository {
  Future<Either<ChatModel, AppError>> createOrUpdate({
    required ChatModel data,
    String? chatId,
  });

  Future<AppError?> addMember({
    required List<UserModel> memers,
    required String chatId,
  });

  Future<AppError?> removeMember({
    required List<UserModel> memers,
    required String chatId,
  });

  Future<AppError?> delete({required String id});

  Future<AppError?> sendOrUpdateMessage({
    required Message data,
    required String chatId,
    String? id,
    required String idKey,
  });

  Future<AppError?> deleteMessage({
    required String id,
    required String chatId,
  });

  Stream<Either<List<ChatModel>, AppError>> get();

  Stream<Either<List<Message>, AppError>> getMessages({required String chatId});

  Future<String> isExitMessage({
    required List<UserModel> members,
  });
}
