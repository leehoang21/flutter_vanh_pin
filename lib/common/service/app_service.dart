import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:pinpin/common/configs/default_environment.dart';
import 'package:pinpin/common/configs/local_storage/local_storage.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:injectable/injectable.dart';
import '../../presentation/bloc/base_bloc/base_bloc.dart';

@singleton
class AppService extends BaseBloc<AppServiceState> {
  AppService(this.localStorage) : super(AppServiceState.initial());

  final LocalStorage localStorage;

  void setUser(UserModel? user) {
    emit(AppServiceState(user: user));
    localStorage.write(DefaultEnvironment.user, json.encode(user?.toJson()));
  }
}

class AppServiceState extends Equatable {
  final UserModel? user;

  const AppServiceState({this.user});

  @override
  List<Object?> get props => [user];

  AppServiceState copyWith({
    UserModel? user,
  }) {
    return AppServiceState(
      user: user ?? this.user,
    );
  }

  factory AppServiceState.initial() {
    // ignore: prefer_const_literals_to_create_immutables
    return const AppServiceState(user: null);
  }
}
