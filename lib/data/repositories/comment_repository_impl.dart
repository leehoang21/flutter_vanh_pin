import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:pinpin/common/configs/notification_config/notification_config.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/domain/repositories/post_reposotory.dart';
import '../../common/configs/default_environment.dart';
import '../../common/configs/firebase_config.dart';
import '../../common/exception/app_error.dart';
import '../../domain/repositories/comment_reposotory.dart';
import '../models/comment_model.dart';
import '../models/notification_model.dart';

@Injectable(as: CommentRepository)
class CommentRepositoryImpl extends CommentRepository {
  final FirebaseConfig config;
  final AppService appService;
  final PostRepository postRepository;
  final NotificationConfig notificationConfig;

  CommentRepositoryImpl(
    this.config,
    this.appService,
    this.postRepository,
    this.notificationConfig,
  );

  CollectionReference<Map<String, dynamic>> get _doc =>
      config.userDoc.collection(DefaultEnvironment.post);

  @override
  Future<AppError?> create({
    required CommentModel model,
  }) async {
    if (config.auth.currentUser == null) return null;
    try {
      final param = model.toJson();
      await _doc
          .doc(model.postId)
          .collection(DefaultEnvironment.comment)
          .add(param);
      notificationConfig.sendMessenger(
        NotificationModel(
          type: NotificationType.comment,
          createdAt: DateTime.now(),
          author: appService.state.user,
          user: model.author,
          content: model.content,
        ),
      );
      await postRepository.updateCommentCount(true, model.postId);
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }

  @override
  Stream<Either<List<CommentModel>, AppError>> get(String postId) {
    final comments = _doc
        .doc(postId)
        .collection(DefaultEnvironment.comment)
        .orderBy('time', descending: true)
        .snapshots()
        .map<Either<List<CommentModel>, AppError>>((event) {
      try {
        final list =
            event.docs.map((e) => CommentModel.fromJson(e.data())).toList();
        return Left(list);
      } catch (e) {
        return Right(AppError(message: e.toString()));
      }
    });

    return comments;
  }
}
