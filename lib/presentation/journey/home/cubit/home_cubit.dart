import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../bloc/base_bloc/base_bloc.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends BaseBloc<HomeState> {
  HomeCubit() : super(const HomeState.loading());

  @override
  Future onInit() async {
    super.onInit();
  }
}
