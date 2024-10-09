import 'dart:async';
import 'package:pinpin/common/extension/bloc_extension.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/data/models/comment_model.dart';
import 'package:pinpin/domain/use_cases/comment_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/post_model.dart';
import '../../../bloc/base_bloc/base_bloc.dart';

part 'comment_cubit.freezed.dart';
part 'comment_state.dart';

@injectable
class CommentCubit extends BaseBloc<CommentState> {
  CommentCubit(this.commentUseCase, this.appService)
      : super(const CommentState([]));
  final CommentUseCase commentUseCase;
  StreamSubscription _commentSubscription = const Stream.empty().listen((_) {});
  late final PostModel post;
  final AppService appService;

  @override
  initState(List<dynamic> params) {
    post = params[0] as PostModel;
    init();
  }

  init() {
    getComment();
  }

  @override
  Future<void> close() {
    _commentSubscription.cancel();
    return super.close();
  }

  void send(String content) async {
    showLoading();
    final result = await commentUseCase.create(
      model: CommentModel(
        author: appService.state.user!,
        time: DateTime.now(),
        content: content,
        postId: post.uId!,
      ),
    );
    if (result != null) {
      showSnackbar(translationKey: result.toString());
    }
    hideLoading();
  }

  void getComment() async {
    _commentSubscription.cancel();
    _commentSubscription = commentUseCase.get(post.uId!).listen((event) {
      event.fold(
        (posts) {
          emit(CommentState(posts));
        },
        (error) {
          showSnackbar(translationKey: error.toString());
        },
      );
    });
  }
}
