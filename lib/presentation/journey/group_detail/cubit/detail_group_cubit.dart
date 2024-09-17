import 'dart:async';
import 'package:pinpin/common/extension/bloc_extension.dart';
import 'package:pinpin/data/models/group_model.dart';
import 'package:pinpin/domain/use_cases/post_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/post_model.dart';
import '../../../bloc/base_bloc/base_bloc.dart';

part 'detail_group_cubit.freezed.dart';
part 'detail_group_state.dart';

@injectable
class GroupDetailCubit extends BaseBloc<GroupDetailState> {
  GroupDetailCubit(this.postUseCase) : super(const GroupDetailState([]));
  final PostUseCase postUseCase;
  StreamSubscription _postSubscription = const Stream.empty().listen((_) {});
  late final GroupModel data;

  initState(GroupModel data) {
    this.data = data;
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

    final result = postUseCase.getToGroup([data.uId ?? '']);
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
}
