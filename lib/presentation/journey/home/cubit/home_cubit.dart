import 'dart:async';
import 'package:pinpin/common/extension/bloc_extension.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/domain/use_cases/post_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/domain/use_cases/user_use_case.dart';

import '../../../../data/models/post_model.dart';
import '../../../../data/models/user_model.dart';
import '../../../bloc/base_bloc/base_bloc.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends BaseBloc<HomeState> {
  HomeCubit(this.postUseCase, this.userUseCase, this.appService)
      : super(const HomeState({}, []));
  final PostUseCase postUseCase;
  final UserUseCase userUseCase;
  final AppService appService;
  StreamSubscription _postSubscription = const Stream.empty().listen((_) {});

  @override
  Future onInit() async {
    getPosts();
    getUsers();
    super.onInit();
  }

  void getUsers() async {
    final users = await userUseCase.getAll();
    final user = appService.state.user;
    final friends = user?.friends ?? [];

    //remove current user and friends
    users.removeWhere((element) => element.uId == user?.uId);
    users.removeWhere(
      (element) => friends.any(
        (friend) => friend.user?.uId == element.uId,
      ),
    );
    emit(state.copyWith(users: users));
  }

  @override
  Future<void> close() {
    _postSubscription.cancel();
    return super.close();
  }

  share(
    PostModel post,
    String content,
  ) {
    postUseCase.create(content: content, images: [], share: post);
  }

  void getPosts() async {
    _postSubscription.cancel();
    _postSubscription = postUseCase.get().listen((event) {
      event.fold(
        (posts) {
          emit(
            state.copyWith(
              posts: {
                ...state.posts,
                ...posts,
              },
            ),
          );
        },
        (error) {
          showSnackbar(translationKey: error.toString());
        },
      );
    });
  }
}
