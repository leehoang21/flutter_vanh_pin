import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/data/models/chat_model.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:pinpin/domain/repositories/chat_reposotory.dart';

import '../../common/exception/app_error.dart';
import '../../presentation/widgets/chat_view/chatview.dart';

@injectable
class ChatUseCase {
  final ChatRepository repository;

  ChatUseCase({required this.repository});

  Future<Either<ChatModel, AppError>> createOrUpdate({
    required ChatModel data,
    String? chatId,
  }) {
    return repository.createOrUpdate(data: data, chatId: chatId);
  }

  Future<AppError?> addMember({
    required List<UserModel> memers,
    required String chatId,
  }) {
    return repository.addMember(memers: memers, chatId: chatId);
  }

  Future<AppError?> removeMember({
    required List<UserModel> memers,
    required String chatId,
  }) {
    return repository.removeMember(memers: memers, chatId: chatId);
  }

  Future<AppError?> delete({required String id}) {
    return repository.delete(id: id);
  }

  Future<AppError?> deleteMessage({
    required String id,
    required String chatId,
  }) {
    return repository.deleteMessage(id: id, chatId: chatId);
  }

  Future<AppError?> sendOrUpdateMessage({
    required Message data,
    required String chatId,
    required String idKey,
  }) {
    return repository.sendOrUpdateMessage(
        data: data, chatId: chatId, idKey: idKey);
  }

  Stream<Either<List<ChatModel>, AppError>> get() {
    return repository.get();
  }

  Stream<Either<List<Message>, AppError>> getMessages(
      {required String chatId}) {
    return repository.getMessages(chatId: chatId);
  }

  Future<String> isExitMessage({
    required List<UserModel> members,
  }) {
    return repository.isExitMessage(members: members);
  }
}
