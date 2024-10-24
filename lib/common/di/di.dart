import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import '../../presentation/routers/app_router.dart';
import 'di.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future configureDependencies() async {
  getIt.registerLazySingleton(() => AppRouter());
  getIt.registerLazySingleton(() => BaseOptions());

  getIt.init();
}
