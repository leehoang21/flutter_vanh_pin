import 'dart:async';
import 'package:flutter_pin/common/extension/bloc_extension.dart';
import 'package:flutter_pin/domain/use_cases/post_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/post_model.dart';
import '../../../bloc/base_bloc/base_bloc.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends BaseBloc<HomeState> {
  HomeCubit(this.postUseCase) : super(const HomeState.loading());
  final PostUseCase postUseCase;

  @override
  Future onInit() async {
    getPosts();
    super.onInit();
  }

  void getPosts() async {
    final result = await postUseCase.get();
    result.fold(
      (posts) => emit(HomeState.loaded(posts)),
      (error) => showSnackbar(translationKey: error.toString()),
    );
  }
}
