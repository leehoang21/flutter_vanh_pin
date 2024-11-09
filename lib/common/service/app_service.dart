import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    emit(state.copyWith(user: user));
    localStorage.write(DefaultEnvironment.user, json.encode(user?.toJson()));
  }

  void setCredential(AuthCredential? credential) {
    emit(state.copyWith(credential: credential));
  }
}

class AppServiceState extends Equatable {
  final UserModel? user;
  final AuthCredential? credential;

  const AppServiceState(this.user, this.credential);

  @override
  List<Object?> get props => [user, credential];

  AppServiceState copyWith({
    UserModel? user,
    AuthCredential? credential,
  }) {
    return AppServiceState(
      user ?? this.user,
      credential ?? this.credential,
    );
  }

  factory AppServiceState.initial() {
    // ignore: prefer_const_literals_to_create_immutables
    return const AppServiceState(null, null);
  }
}
