// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pinpin/common/di/di.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pinpin/presentation/bloc/loading_bloc/loading_bloc.dart';
import 'package:pinpin/presentation/routers/app_router.dart';

import '../../presentation/widgets/snackbar_widget/snackbar_widget.dart';

extension BlocExtension on BaseBloc {
  void showLoading() {
    getIt.get<LoadingBloc>().startLoading();
  }

  void hideLoading() {
    getIt.get<LoadingBloc>().finishLoading();
  }

  void showSnackbar({
    SnackBarType type = SnackBarType.error,
    String? translationKey,
  }) {
    TopSnackBar(
      title: (translationKey ?? '').tr,
      type: type,
    ).show(getIt.get<AppRouter>().navigatorKey.currentContext!);
  }

  Future<T?> push<T extends Object?>(PageRouteInfo<dynamic> route,
      {void Function(NavigationFailure)? onFailure}) {
    return getIt
        .get<AppRouter>()
        .navigatorKey
        .currentContext!
        .pushRoute(route, onFailure: onFailure);
  }

  Future<T?> replace<T extends Object?>(PageRouteInfo<dynamic> route,
      {void Function(NavigationFailure)? onFailure}) {
    return getIt
        .get<AppRouter>()
        .navigatorKey
        .currentContext!
        .router
        .replace(route, onFailure: onFailure);
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(
    PageRouteInfo<dynamic> route, {
    required bool Function(Route<dynamic>) predicate,
    void Function(NavigationFailure)? onFailure,
  }) {
    return getIt
        .get<AppRouter>()
        .navigatorKey
        .currentContext!
        .router
        .pushAndPopUntil(route, predicate: predicate, onFailure: onFailure);
  }

  Future<bool> pop<T extends Object?>(T? result) {
    return getIt
        .get<AppRouter>()
        .navigatorKey
        .currentContext!
        .router
        .pop(result);
  }
}
