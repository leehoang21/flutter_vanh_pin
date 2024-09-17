import 'dart:async';
import 'package:pinpin/common/extension/bloc_extension.dart';
import 'package:pinpin/domain/use_cases/post_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/post_model.dart';
import '../../../bloc/base_bloc/base_bloc.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends BaseBloc<HomeState> {
  HomeCubit(this.postUseCase) : super(const HomeState({}));
  final PostUseCase postUseCase;
  StreamSubscription _postSubscription = const Stream.empty().listen((_) {});

  @override
  Future onInit() async {
    getPosts();
    super.onInit();
  }

  @override
  Future<void> close() {
    _postSubscription.cancel();
    return super.close();
  }

  void getPosts() async {
    _postSubscription.cancel();
    _postSubscription = postUseCase.get().listen((event) {
      event.fold(
        (posts) {
          emit(HomeState({
            ...state.posts,
            ...posts,
          }));
        },
        (error) {
          showSnackbar(translationKey: error.toString());
        },
      );
    });
  }
}
