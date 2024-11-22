import 'package:auto_route/auto_route.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/common/assets/assets.gen.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/presentation/routers/app_router.dart';
import '../../themes/themes.dart';
import 'bloc/tab_manger_cubit.dart';
import 'main_constants.dart';
import 'widget/bottom_navigation_bar_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: context.read<TabMangerCubit>().tabs,
      lazyLoad: true,
      transitionBuilder: (context, child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      builder: (context, child) => FloatingDraggableWidget(
        floatingWidget: FloatingActionButton(
          backgroundColor: AppColor.black,
          onPressed: () async {
            context.pushRoute(const ChatRoute());
          },
          shape: const CircleBorder(),
          child: Center(
            child: Assets.icons.message
                // ignore: deprecated_member_use_from_same_package
                .svg(color: AppColor.white, height: 30.sp, width: 30.sp),
          ),
        ),
        mainScreenWidget: Scaffold(
          body: child,
          bottomNavigationBar: const _BuildBottomNavigationBar(),
        ),
        dy: 0.8.sh,
        dx: 0.8.sw,
        floatingWidgetWidth: MainConstants.floatingActionButtonIconSize,
        floatingWidgetHeight: MainConstants.floatingActionButtonIconSize,
      ),
    );
  }
}

class _BuildBottomNavigationBar extends StatelessWidget {
  const _BuildBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBarWidget(
      currentIndex: context.watch<TabMangerCubit>().state,
      onTap: (page) {
        context.read<TabMangerCubit>().changePage(page);
        if (page == 2) {
          context.read<AppService>().resetCount();
        }
        context.tabsRouter.setActiveIndex(page);
      },
      iconsData: MainConstants.bottomIconsData,
    );
  }
}
