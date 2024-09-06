import 'package:auto_route/auto_route.dart';
import 'package:flutter_pin/presentation/journey/group/group_screen_provider.dart';
import '../journey/auth/login/login_screen_provider.dart';
import '../journey/auth/register/register_screen_provider.dart';
import '../journey/create_post/create_post_screen_provider.dart';
import '../journey/home/home_screen_provider.dart';
import '../journey/main/main_screen_provider.dart';
import '../journey/my_page/my_page_screen_provider.dart';
import '../journey/notification/notification_screen_provider.dart';
import '../journey/splash/splash_screen.dart';
part 'app_router.gr.dart';
//flutter pub run build_runner build --delete-conflicting-outputs

@AutoRouterConfig(replaceInRouteName: 'ScreenProvider,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        //splash
        AutoRoute(
          page: SplashRoute.page,
          initial: true,
        ),
        //auth
        AutoRoute(
          page: LoginRoute.page,
        ),
        AutoRoute(
          page: RegisterRoute.page,
        ),
        //main
        AutoRoute(
          page: MainRoute.page,
          children: [
            AutoRoute(
              page: HomeRoute.page,
              initial: true,
            ),
            AutoRoute(
              page: GroupRoute.page,
            ),
            AutoRoute(
              page: NotificationRoute.page,
            ),
            AutoRoute(
              page: MyPageRoute.page,
            ),
          ],
        ),
        //create post
        AutoRoute(
          page: CreatePostRoute.page,
        ),
      ];
}
