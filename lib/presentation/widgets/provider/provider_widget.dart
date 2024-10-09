import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pinpin/presentation/widgets/loading_widget/loader_widget.dart';

import '../../../common/di/di.dart';
import '../../bloc/loading_bloc/loading_bloc.dart';

class ProviderWidget<T extends BaseBloc> extends StatefulWidget {
  const ProviderWidget({
    Key? key,
    required this.child,
    required this.params,
  }) : super(key: key);
  final Widget child;
  final List<dynamic> params;

  @override
  // ignore: library_private_types_in_public_api
  _ProviderWidgetState createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends BaseBloc> extends State<ProviderWidget> {
  T? bloc;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    bloc = await getIt.getAsync<T>();
    if (bloc != null) bloc!.initState(widget.params);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (bloc == null) {
      return const Scaffold(
        body: Center(child: LoaderWidget()),
      );
    }

    return BlocProvider(
      create: (context) => bloc!,
      child: widget.child,
    );
  }

  void showLoading() {
    getIt.get<LoadingBloc>().startLoading();
  }

  void hideLoading() {
    getIt.get<LoadingBloc>().finishLoading();
  }
}

class ProviderWidgetNoAsync<T extends BaseBloc> extends StatefulWidget {
  const ProviderWidgetNoAsync({
    Key? key,
    required this.child,
    required this.params,
  }) : super(key: key);
  final Widget child;
  final List<dynamic> params;

  @override
  // ignore: library_private_types_in_public_api
  _ProviderWidgetNoAsyncState createState() => _ProviderWidgetNoAsyncState<T>();
}

class _ProviderWidgetNoAsyncState<T extends BaseBloc>
    extends State<ProviderWidgetNoAsync> {
  T? bloc;

  @override
  void initState() {
    super.initState();
    bloc = getIt.get<T>();
    if (bloc != null) bloc!.initState(widget.params);
  }

  @override
  Widget build(BuildContext context) {
    if (bloc == null) {
      showLoading();
      return Container();
    }
    hideLoading();
    return BlocProvider(
      create: (context) => bloc!,
      child: widget.child,
    );
  }

  void showLoading() {
    getIt.get<LoadingBloc>().startLoading();
  }

  void hideLoading() {
    getIt.get<LoadingBloc>().finishLoading();
  }
}
