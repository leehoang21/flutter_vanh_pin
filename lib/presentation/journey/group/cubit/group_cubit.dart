import 'dart:async';
import 'package:pinpin/common/extension/bloc_extension.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/data/models/group_model.dart';
import 'package:pinpin/domain/repositories/group_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/post_model.dart';
import '../../../bloc/base_bloc/base_bloc.dart';

part 'group_cubit.freezed.dart';
part 'group_state.dart';

@injectable
class GroupCubit extends BaseBloc<GroupState> {
  GroupCubit(this._repository, this._appService)
      : super(const GroupState(groups: [], posts: [], myGroups: []));
  final GroupRepository _repository;
  final AppService _appService;
  StreamSubscription _myGroupSubscription = const Stream.empty().listen((_) {});
  StreamSubscription _unsubscribeGroupSubscription =
      const Stream.empty().listen((_) {});

  @override
  Future onInit() async {
    await getAllGroup();
    await getGroup();

    super.onInit();
  }

  @override
  Future<void> close() {
    _myGroupSubscription.cancel();
    _unsubscribeGroupSubscription.cancel();
    return super.close();
  }

  Future<void> getAllGroup() async {
    _unsubscribeGroupSubscription.cancel();
    final result = _repository.getUnsubscribe(_appService.state.user!.uId!);
    _unsubscribeGroupSubscription = result.listen((event) {
      event.fold(
        (groups) {
          emit(state.copyWith(groups: groups));
        },
        (error) {
          showSnackbar(translationKey: error.message);
        },
      );
    });
  }

  Future<void> getGroup() async {
    _myGroupSubscription.cancel();
    final result = _repository.get(_appService.state.user!.uId!);
    _myGroupSubscription = result.listen((event) {
      event.fold(
        (groups) {
          emit(state.copyWith(myGroups: groups));
        },
        (error) {
          showSnackbar(translationKey: error.message);
        },
      );
    });
  }
}
