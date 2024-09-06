import 'dart:async';
import 'package:flutter_pin/common/service/app_service.dart';
import 'package:flutter_pin/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../bloc/base_bloc/base_bloc.dart';

part 'my_page_cubit.freezed.dart';
part 'my_page_state.dart';

@injectable
class MyPageCubit extends BaseBloc<MyPageState> {
  final AppService appService;
  MyPageCubit(this.appService) : super(MyPageState.loading(appService.user!));

  @override
  Future onInit() async {
    super.onInit();
  }
}
