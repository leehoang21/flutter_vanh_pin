// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../presentation/bloc/loading_bloc/loading_bloc.dart' as _i190;
import '../../presentation/journey/home/cubit/home_cubit.dart' as _i449;
import '../../presentation/journey/main/bloc/tab_manger_cubit.dart' as _i44;
import '../../presentation/journey/my_page/cubit/my_page_cubit.dart' as _i487;
import '../../presentation/widgets/pick_image/cubit/pick_image_cubit.dart'
    as _i573;
import '../configs/dio/dio_config.dart' as _i576;
import '../configs/firebase_config.dart' as _i585;
import '../configs/lang/translate_preferences.dart' as _i96;
import '../configs/local_storage/local_storage.dart' as _i439;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i449.HomeCubit>(() => _i449.HomeCubit());
    gh.factory<_i44.TabMangerCubit>(() => _i44.TabMangerCubit());
    gh.factory<_i487.MyPageCubit>(() => _i487.MyPageCubit());
    gh.factory<_i573.PickImageCubit>(() => _i573.PickImageCubit());
    gh.singleton<_i585.FirebaseConfig>(() => _i585.FirebaseConfig()..init());
    gh.singleton<_i439.LocalStorage>(() => _i439.LocalStorage());
    gh.lazySingleton<_i190.LoadingBloc>(() => _i190.LoadingBloc());
    gh.lazySingleton<_i576.DioApiClient>(
        () => _i576.DioApiClient(options: gh<_i361.BaseOptions>()));
    gh.singleton<_i96.TranslatePreferences>(
        () => _i96.TranslatePreferences(gh<_i439.LocalStorage>()));
    return this;
  }
}
