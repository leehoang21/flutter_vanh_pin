import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:pinpin/common/extension/bloc_extension.dart';
import 'package:pinpin/data/models/group_model.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:pinpin/domain/use_cases/group_use_case.dart';
import 'package:pinpin/domain/use_cases/post_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/post_model.dart';
import '../../../bloc/base_bloc/base_bloc.dart';

part 'detail_group_state.dart';

@injectable
class GroupDetailCubit extends BaseBloc<GroupDetailState> {
  GroupDetailCubit(this.postUseCase, this.groupUseCase)
      : super(const GroupDetailState([], GroupModel()));
  final PostUseCase postUseCase;
  final GroupUseCase groupUseCase;
  StreamSubscription _postSubscription = const Stream.empty().listen((_) {});
  StreamSubscription _groupDetailSubscription =
      const Stream.empty().listen((_) {});

  @override
  initState(List params) {
    final data = params[0] as GroupModel;
    emit(state.copyWith(model: data));
    init();
  }

  init() {
    getPostToGroup();
  }

  @override
  Future<void> close() {
    _postSubscription.cancel();
    return super.close();
  }

  Future<void> getPostToGroup() async {
    _postSubscription.cancel();

    final result = postUseCase.getToGroup([state.model.uId ?? '']);
    _postSubscription = result.listen((event) {
      event.fold(
        (posts) {
          emit(state.copyWith(posts: posts));
        },
        (error) {
          showSnackbar(translationKey: error.message);
        },
      );
    });
  }

  getDetail() {
    _groupDetailSubscription.cancel();
    final result = groupUseCase.getDetail(state.model.uId ?? '');
    _groupDetailSubscription = result.listen((event) {
      event.fold(
        (model) {
          emit(state.copyWith(model: model));
        },
        (error) {
          showSnackbar(translationKey: error.message);
        },
      );
    });
  }

  addMember(List<UserModel> users) async {
    for (final user in users) {
      await groupUseCase.addMembers(user, state.model.uId ?? '');
    }
  }
}
