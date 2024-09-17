// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/repositories/auth_repository_impl.dart' as _i895;
import '../../data/repositories/group_repository_impl.dart' as _i654;
import '../../data/repositories/post_repository_impl.dart' as _i704;
import '../../data/repositories/storage_repository_impl.dart' as _i47;
import '../../data/repositories/user_repository_impl.dart' as _i790;
import '../../domain/repositories/auth_repository.dart' as _i1073;
import '../../domain/repositories/group_repository.dart' as _i708;
import '../../domain/repositories/post_reposotory.dart' as _i941;
import '../../domain/repositories/storage_repository.dart' as _i101;
import '../../domain/repositories/user_repository.dart' as _i271;
import '../../domain/use_cases/auth_use_case.dart' as _i1063;
import '../../domain/use_cases/group_use_case.dart' as _i823;
import '../../domain/use_cases/post_use_case.dart' as _i652;
import '../../domain/use_cases/storage_use_case.dart' as _i967;
import '../../presentation/bloc/loading_bloc/loading_bloc.dart' as _i190;
import '../../presentation/journey/auth/login/cubit/login_cubit.dart' as _i217;
import '../../presentation/journey/auth/register/cubit/register_cubit.dart'
    as _i863;
import '../../presentation/journey/create_group/cubit/create_group_cubit.dart'
    as _i728;
import '../../presentation/journey/create_post/cubit/create_post_cubit.dart'
    as _i941;
import '../../presentation/journey/group/cubit/group_cubit.dart' as _i550;
import '../../presentation/journey/group_detail/cubit/detail_group_cubit.dart'
    as _i299;
import '../../presentation/journey/home/cubit/home_cubit.dart' as _i449;
import '../../presentation/journey/main/bloc/tab_manger_cubit.dart' as _i44;
import '../../presentation/journey/my_page/cubit/my_page_cubit.dart' as _i487;
import '../../presentation/journey/notification/cubit/notification_cubit.dart'
    as _i230;
import '../configs/firebase_config.dart' as _i585;
import '../configs/lang/translate_preferences.dart' as _i96;
import '../configs/local_storage/local_storage.dart' as _i439;
import '../service/app_service.dart' as _i307;

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
    gh.factory<_i44.TabMangerCubit>(() => _i44.TabMangerCubit());
    gh.factory<_i230.NotificationCubit>(() => _i230.NotificationCubit());
    gh.singleton<_i585.FirebaseConfig>(() => _i585.FirebaseConfig()..init());
    gh.singleton<_i439.LocalStorage>(() => _i439.LocalStorage());
    gh.singleton<_i307.AppService>(() => _i307.AppService());
    gh.lazySingleton<_i190.LoadingBloc>(() => _i190.LoadingBloc());
    gh.factory<_i101.StorageRepository>(
        () => _i47.StorageRepositoryImpl(gh<_i585.FirebaseConfig>()));
    gh.factory<_i1073.AuthRepository>(
        () => _i895.AuthRepositoryImpl(gh<_i585.FirebaseConfig>()));
    gh.factory<_i941.PostRepository>(() => _i704.PostRepositoryImpl(
          gh<_i585.FirebaseConfig>(),
          gh<_i307.AppService>(),
        ));
    gh.factory<_i967.StorageUseCase>(
        () => _i967.StorageUseCase(gh<_i101.StorageRepository>()));
    gh.singleton<_i96.TranslatePreferences>(
        () => _i96.TranslatePreferences(gh<_i439.LocalStorage>()));
    gh.factory<_i271.UserRepository>(() => _i790.UserRepositoryImpl(
          gh<_i585.FirebaseConfig>(),
          gh<_i101.StorageRepository>(),
        ));
    gh.factory<_i652.PostUseCase>(
        () => _i652.PostUseCase(repository: gh<_i941.PostRepository>()));
    gh.factory<_i941.CreatePostCubit>(() => _i941.CreatePostCubit(
          gh<_i967.StorageUseCase>(),
          gh<_i652.PostUseCase>(),
        ));
    gh.factory<_i299.GroupDetailCubit>(
        () => _i299.GroupDetailCubit(gh<_i652.PostUseCase>()));
    gh.factory<_i449.HomeCubit>(() => _i449.HomeCubit(gh<_i652.PostUseCase>()));
    gh.factory<_i487.MyPageCubit>(
        () => _i487.MyPageCubit(gh<_i652.PostUseCase>()));
    gh.factory<_i708.GroupRepository>(() => _i654.GroupRepositoryImpl(
          gh<_i585.FirebaseConfig>(),
          gh<_i307.AppService>(),
          gh<_i271.UserRepository>(),
        ));
    gh.factory<_i1063.AuthUseCase>(() => _i1063.AuthUseCase(
          repository: gh<_i1073.AuthRepository>(),
          userRepository: gh<_i271.UserRepository>(),
          appService: gh<_i307.AppService>(),
        ));
    gh.factory<_i550.GroupCubit>(() => _i550.GroupCubit(
          gh<_i708.GroupRepository>(),
          gh<_i941.PostRepository>(),
          gh<_i307.AppService>(),
        ));
    gh.factory<_i823.GroupUseCase>(
        () => _i823.GroupUseCase(repository: gh<_i708.GroupRepository>()));
    gh.factory<_i217.LoginCubit>(
        () => _i217.LoginCubit(gh<_i1063.AuthUseCase>()));
    gh.factory<_i728.CreateGroupCubit>(() => _i728.CreateGroupCubit(
          gh<_i967.StorageUseCase>(),
          gh<_i823.GroupUseCase>(),
          gh<_i307.AppService>(),
        ));
    gh.factory<_i863.RegisterCubit>(() => _i863.RegisterCubit(
          pickImageUseCase: gh<_i967.StorageUseCase>(),
          authUseCase: gh<_i1063.AuthUseCase>(),
        ));
    return this;
  }
}
