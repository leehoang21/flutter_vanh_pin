import 'package:auto_route/auto_route.dart';
import 'package:pinpin/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pinpin/presentation/routers/app_router.dart';
import 'package:injectable/injectable.dart';

@injectable
class TabMangerCubit extends BaseBloc<int> {
  TabMangerCubit() : super(0);

  late final List<PageRouteInfo<dynamic>> tabs;

  void changePage(int index) {
    emit(index);
  }

  @override
  onInit() {
    tabs = _initTab();
  }

  List<PageRouteInfo<dynamic>> _initTab() {
    return [
      const HomeRoute(),
      const GroupRoute(),
      const NotificationRoute(),
      MyPageRoute(user: null),
    ];
  }
}
