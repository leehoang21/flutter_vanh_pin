import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_pin/common/service/app_service.dart';
import 'package:flutter_pin/data/models/post_model.dart';
import 'package:flutter_pin/data/models/user_model.dart';
import 'package:injectable/injectable.dart';
import '../../common/configs/default_environment.dart';
import '../../common/configs/firebase_config.dart';
import '../../common/exception/app_error.dart';
import '../../domain/repositories/post_reposotory.dart';

@Injectable(as: PostRepository)
class PostRepositoryImpl extends PostRepository {
  final FirebaseConfig config;
  final AppService appService;
  PostRepositoryImpl(
    this.config,
    this.appService,
  );

  CollectionReference<Map<String, dynamic>> get _doc => config.userDoc
      .collection(config.auth.currentUser?.uid ?? '')
      .doc(DefaultEnvironment.customer)
      .collection(DefaultEnvironment.post);

  @override
  Future<AppError?> create({
    required String content,
    required List<String> images,
    required UserModel? group,
  }) async {
    if (config.auth.currentUser == null) return null;
    try {
      final param = PostModel(
              author: appService.user!,
              content: content,
              time: DateTime.now(),
              images: images,
              group: group)
          .toJson();
      await _doc.add(param);
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }

  @override
  Future<Either<List<PostModel>, AppError>> get() async {
    try {
      final snapshot = await _doc.orderBy('time', descending: true).get();
      final list =
          snapshot.docs.map((e) => PostModel.fromJson(e.data())).toList();
      return Left(list);
    } catch (e) {
      return Right(AppError(message: e.toString()));
    }
  }
}
