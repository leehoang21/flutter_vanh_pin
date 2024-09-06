import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../bloc/base_bloc/base_bloc.dart';

part 'group_cubit.freezed.dart';
part 'group_state.dart';

@injectable
class GroupCubit extends BaseBloc<GroupState> {
  GroupCubit() : super(const GroupState.loading());

  @override
  Future onInit() async {
    super.onInit();
  }
}
