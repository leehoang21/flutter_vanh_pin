import 'package:either_dart/either.dart';
import 'package:flutter_pin/data/models/user_model.dart';
import 'package:flutter_pin/domain/repositories/image_repository.dart';
import 'package:flutter_pin/domain/repositories/post_reposotory.dart';
import 'package:injectable/injectable.dart';

import '../../common/exception/app_error.dart';
import '../../data/models/post_model.dart';

@injectable
class PostUseCase {
  final PostRepository repository;
  final ImageRepository imageRepository;

  PostUseCase({
    required this.repository,
    required this.imageRepository,
  });

  Future<AppError?> create({
    required String content,
    required List<String> images,
    UserModel? group,
  }) async {
    imageRepository.add(images: images);
    return repository.create(content: content, images: images, group: group);
  }

  Future<Either<List<PostModel>, AppError>> get() async {
    return repository.get();
  }
}
