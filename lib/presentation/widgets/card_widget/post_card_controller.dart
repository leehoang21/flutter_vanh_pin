import 'package:injectable/injectable.dart';
import 'package:pinpin/domain/use_cases/post_use_case.dart';

@injectable
class PostCardController {
  final PostUseCase _usecase;

  PostCardController({required PostUseCase usecase}) : _usecase = usecase;

  delete(String postId) async {
    await _usecase.delete(postId: postId);
  }
}
