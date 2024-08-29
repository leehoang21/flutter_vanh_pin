import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../bloc/base_bloc/base_bloc.dart';

part 'my_page_cubit.freezed.dart';
part 'my_page_state.dart';

@injectable
class MyPageCubit extends BaseBloc<MyPageState> {
  MyPageCubit() : super(const MyPageState.loading());

  @override
  Future onInit() async {
    super.onInit();
  }
}
