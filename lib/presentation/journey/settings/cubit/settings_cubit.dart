import 'dart:async';
import 'package:pinpin/common/extension/bloc_extension.dart';
import 'package:pinpin/data/models/post_model.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/use_cases/post_use_case.dart';
import '../../../bloc/base_bloc/base_bloc.dart';

part 'my_page_cubit.freezed.dart';
part 'settings_state.dart';

@injectable
class MyPageCubit extends BaseBloc<MyPageState> {
  final PostUseCase postUseCase;
  MyPageCubit(this.postUseCase) : super(const MyPageState(UserModel(), []));
  late final UserModel user;
  StreamSubscription _postSubscription = const Stream.empty().listen((_) {});

  initState(UserModel user) {
    emit(MyPageState(user, []));
    init();
  }

  init() {
    getPosts();
  }

  void getPosts() async {
    _postSubscription.cancel();
    _postSubscription =
        postUseCase.getToUser(state.user.uId ?? '').listen((event) {
      event.fold(
        (posts) {
          emit(state.copyWith(posts: posts));
        },
        (error) {
          showSnackbar(translationKey: error.toString());
        },
      );
    });
  }
}
