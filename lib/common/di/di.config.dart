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

import '../../data/repositories/auth_repository_impl.dart' as _i895;
import '../../data/repositories/chat_repository_impl.dart' as _i838;
import '../../data/repositories/comment_repository_impl.dart' as _i683;
import '../../data/repositories/friend_repository_impl.dart' as _i185;
import '../../data/repositories/group_repository_impl.dart' as _i654;
import '../../data/repositories/notification_repository_impl.dart' as _i950;
import '../../data/repositories/post_repository_impl.dart' as _i704;
import '../../data/repositories/storage_repository_impl.dart' as _i47;
import '../../data/repositories/user_repository_impl.dart' as _i790;
import '../../domain/repositories/auth_repository.dart' as _i1073;
import '../../domain/repositories/chat_reposotory.dart' as _i606;
import '../../domain/repositories/comment_reposotory.dart' as _i1036;
import '../../domain/repositories/friend_repository.dart' as _i243;
import '../../domain/repositories/group_repository.dart' as _i708;
import '../../domain/repositories/notification_repository.dart' as _i1060;
import '../../domain/repositories/post_reposotory.dart' as _i941;
import '../../domain/repositories/storage_repository.dart' as _i101;
import '../../domain/repositories/user_repository.dart' as _i271;
import '../../domain/use_cases/auth_use_case.dart' as _i1063;
import '../../domain/use_cases/chat_use_case.dart' as _i140;
import '../../domain/use_cases/comment_use_case.dart' as _i657;
import '../../domain/use_cases/friend_use_case.dart' as _i343;
import '../../domain/use_cases/group_use_case.dart' as _i823;
import '../../domain/use_cases/notification_use_case.dart' as _i986;
import '../../domain/use_cases/post_use_case.dart' as _i652;
import '../../domain/use_cases/storage_use_case.dart' as _i967;
import '../../domain/use_cases/user_use_case.dart' as _i390;
import '../../presentation/bloc/loading_bloc/loading_bloc.dart' as _i190;
import '../../presentation/journey/auth/login/cubit/login_cubit.dart' as _i217;
import '../../presentation/journey/auth/register/cubit/register_cubit.dart'
    as _i863;
import '../../presentation/journey/chat/cubit/chat_cubit.dart' as _i299;
import '../../presentation/journey/chat_detail/cubit/chat_detail_cubit.dart'
    as _i1004;
import '../../presentation/journey/comment/cubit/comment_cubit.dart' as _i618;
import '../../presentation/journey/create_chat/cubit/create_chat_cubit.dart'
    as _i290;
import '../../presentation/journey/create_group/cubit/create_group_cubit.dart'
    as _i728;
import '../../presentation/journey/create_group_chat/cubit/create_group_chat_cubit.dart'
    as _i301;
import '../../presentation/journey/create_post/cubit/create_post_cubit.dart'
    as _i941;
import '../../presentation/journey/edit_profile/cubit/edit_profile_cubit.dart'
    as _i530;
import '../../presentation/journey/friend/cubit/friend_cubit.dart' as _i776;
import '../../presentation/journey/group/cubit/group_cubit.dart' as _i550;
import '../../presentation/journey/group_detail/cubit/detail_group_cubit.dart'
    as _i299;
import '../../presentation/journey/home/cubit/home_cubit.dart' as _i449;
import '../../presentation/journey/main/bloc/tab_manger_cubit.dart' as _i44;
import '../../presentation/journey/my_page/cubit/my_page_cubit.dart' as _i487;
import '../../presentation/journey/notification/cubit/notification_cubit.dart'
    as _i230;
import '../../presentation/journey/profile_third/cubit/profile_third_cubit.dart'
    as _i77;
import '../../presentation/journey/settings/cubit/settings_cubit.dart' as _i121;
import '../../presentation/journey/splash/splash_controller.dart' as _i675;
import '../../presentation/widgets/card_widget/post_card_controller.dart'
    as _i517;
import '../configs/dio/dio_config.dart' as _i576;
import '../configs/firebase_config.dart' as _i585;
import '../configs/lang/translate_preferences.dart' as _i96;
import '../configs/local_storage/local_storage.dart' as _i439;
import '../configs/notification_config/notification_config.dart' as _i843;
import '../service/app_service.dart' as _i307;
import '../service/key.dart' as _i769;

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
    gh.singletonAsync<_i585.FirebaseConfig>(() {
      final i = _i585.FirebaseConfig();
      return i.init().then((_) => i);
    });
    gh.singleton<_i439.LocalStorage>(() => _i439.LocalStorage());
    gh.lazySingleton<_i190.LoadingBloc>(() => _i190.LoadingBloc());
    gh.factoryAsync<_i101.StorageRepository>(() async =>
        _i47.StorageRepositoryImpl(await getAsync<_i585.FirebaseConfig>()));
    gh.lazySingleton<_i576.DioApiClient>(
        () => _i576.DioApiClient(options: gh<_i361.BaseOptions>()));
    gh.factoryAsync<_i967.StorageUseCase>(() async =>
        _i967.StorageUseCase(await getAsync<_i101.StorageRepository>()));
    gh.singleton<_i96.TranslatePreferences>(
        () => _i96.TranslatePreferences(gh<_i439.LocalStorage>()));
    gh.singleton<_i307.AppService>(
        () => _i307.AppService(gh<_i439.LocalStorage>()));
    gh.singletonAsync<_i769.KeyService>(() {
      final i = _i769.KeyService(gh<_i439.LocalStorage>());
      return i.init().then((_) => i);
    });
    gh.singletonAsync<_i843.NotificationConfig>(() async {
      final i = _i843.NotificationConfig(
        gh<_i576.DioApiClient>(),
        gh<_i307.AppService>(),
        firebaseConfig: await getAsync<_i585.FirebaseConfig>(),
      );
      return i.init().then((_) => i);
    });
    gh.factoryAsync<_i1073.AuthRepository>(() async => _i895.AuthRepositoryImpl(
          await getAsync<_i585.FirebaseConfig>(),
          gh<_i576.DioApiClient>(),
          gh<_i307.AppService>(),
          gh<_i439.LocalStorage>(),
        ));
    gh.factoryAsync<_i941.PostRepository>(() async => _i704.PostRepositoryImpl(
          await getAsync<_i585.FirebaseConfig>(),
          gh<_i307.AppService>(),
        ));
    gh.factoryAsync<_i1060.NotificationRepository>(
        () async => _i950.NotificationRepositoryImpl(
              await getAsync<_i585.FirebaseConfig>(),
              await getAsync<_i101.StorageRepository>(),
              gh<_i307.AppService>(),
            ));
    gh.factoryAsync<_i243.FriendRepository>(
        () async => _i185.FriendRepositoryImpl(
              await getAsync<_i585.FirebaseConfig>(),
              await getAsync<_i101.StorageRepository>(),
              gh<_i307.AppService>(),
              await getAsync<_i1060.NotificationRepository>(),
            ));
    gh.factoryAsync<_i1036.CommentRepository>(
        () async => _i683.CommentRepositoryImpl(
              await getAsync<_i585.FirebaseConfig>(),
              gh<_i307.AppService>(),
              await getAsync<_i941.PostRepository>(),
            ));
    gh.factoryAsync<_i986.NotificationUseCase>(() async =>
        _i986.NotificationUseCase(
            repository: await getAsync<_i1060.NotificationRepository>()));
    gh.factoryAsync<_i652.PostUseCase>(() async =>
        _i652.PostUseCase(repository: await getAsync<_i941.PostRepository>()));
    gh.factoryAsync<_i941.CreatePostCubit>(() async => _i941.CreatePostCubit(
          await getAsync<_i967.StorageUseCase>(),
          await getAsync<_i652.PostUseCase>(),
        ));
    gh.factoryAsync<_i657.CommentUseCase>(() async => _i657.CommentUseCase(
        repository: await getAsync<_i1036.CommentRepository>()));
    gh.factoryAsync<_i271.UserRepository>(() async => _i790.UserRepositoryImpl(
          await getAsync<_i585.FirebaseConfig>(),
          await getAsync<_i101.StorageRepository>(),
          gh<_i307.AppService>(),
          await getAsync<_i243.FriendRepository>(),
          await getAsync<_i769.KeyService>(),
        ));
    gh.factoryAsync<_i343.FriendUseCase>(() async => _i343.FriendUseCase(
        repository: await getAsync<_i243.FriendRepository>()));
    gh.factoryAsync<_i618.CommentCubit>(() async => _i618.CommentCubit(
          await getAsync<_i657.CommentUseCase>(),
          gh<_i307.AppService>(),
        ));
    gh.factoryAsync<_i517.PostCardController>(() async =>
        _i517.PostCardController(usecase: await getAsync<_i652.PostUseCase>()));
    gh.factoryAsync<_i487.MyPageCubit>(() async => _i487.MyPageCubit(
          await getAsync<_i652.PostUseCase>(),
          gh<_i307.AppService>(),
        ));
    gh.factoryAsync<_i708.GroupRepository>(
        () async => _i654.GroupRepositoryImpl(
              await getAsync<_i585.FirebaseConfig>(),
              gh<_i307.AppService>(),
              await getAsync<_i271.UserRepository>(),
            ));
    gh.factoryAsync<_i390.UserUseCase>(() async =>
        _i390.UserUseCase(repository: await getAsync<_i271.UserRepository>()));
    gh.factoryAsync<_i550.GroupCubit>(() async => _i550.GroupCubit(
          await getAsync<_i708.GroupRepository>(),
          await getAsync<_i941.PostRepository>(),
          gh<_i307.AppService>(),
        ));
    gh.factoryAsync<_i823.GroupUseCase>(() async => _i823.GroupUseCase(
        repository: await getAsync<_i708.GroupRepository>()));
    gh.factoryAsync<_i1063.AuthUseCase>(() async => _i1063.AuthUseCase(
          await getAsync<_i1060.NotificationRepository>(),
          await getAsync<_i843.NotificationConfig>(),
          repository: await getAsync<_i1073.AuthRepository>(),
          userRepository: await getAsync<_i271.UserRepository>(),
          appService: gh<_i307.AppService>(),
          localStorage: gh<_i439.LocalStorage>(),
        ));
    gh.factoryAsync<_i728.CreateGroupCubit>(() async => _i728.CreateGroupCubit(
          await getAsync<_i967.StorageUseCase>(),
          await getAsync<_i823.GroupUseCase>(),
          gh<_i307.AppService>(),
        ));
    gh.factoryAsync<_i217.LoginCubit>(() async => _i217.LoginCubit(
          await getAsync<_i1063.AuthUseCase>(),
          gh<_i307.AppService>(),
          await getAsync<_i986.NotificationUseCase>(),
          await getAsync<_i769.KeyService>(),
          await getAsync<_i390.UserUseCase>(),
          gh<_i439.LocalStorage>(),
        ));
    gh.factoryAsync<_i121.SettingsCubit>(() async => _i121.SettingsCubit(
          await getAsync<_i652.PostUseCase>(),
          await getAsync<_i1063.AuthUseCase>(),
        ));
    gh.factoryAsync<_i77.ProfileThirdCubit>(() async => _i77.ProfileThirdCubit(
          await getAsync<_i390.UserUseCase>(),
          await getAsync<_i343.FriendUseCase>(),
        ));
    gh.factoryAsync<_i230.NotificationCubit>(
        () async => _i230.NotificationCubit(
              await getAsync<_i343.FriendUseCase>(),
              gh<_i307.AppService>(),
              await getAsync<_i390.UserUseCase>(),
              await getAsync<_i986.NotificationUseCase>(),
            ));
    gh.factoryAsync<_i606.ChatRepository>(() async => _i838.ChatRepositoryImpl(
          await getAsync<_i585.FirebaseConfig>(),
          gh<_i307.AppService>(),
          await getAsync<_i271.UserRepository>(),
          await getAsync<_i1060.NotificationRepository>(),
          await getAsync<_i843.NotificationConfig>(),
        ));
    gh.factoryAsync<_i449.HomeCubit>(() async => _i449.HomeCubit(
          await getAsync<_i652.PostUseCase>(),
          await getAsync<_i390.UserUseCase>(),
          gh<_i307.AppService>(),
        ));
    gh.factoryAsync<_i776.FriendCubit>(() async => _i776.FriendCubit(
          gh<_i307.AppService>(),
          await getAsync<_i343.FriendUseCase>(),
          userUseCase: await getAsync<_i390.UserUseCase>(),
        ));
    gh.factoryAsync<_i530.EditProfileCubit>(() async => _i530.EditProfileCubit(
          pickImageUseCase: await getAsync<_i967.StorageUseCase>(),
          userUseCase: await getAsync<_i390.UserUseCase>(),
        ));
    gh.factoryAsync<_i863.RegisterCubit>(() async => _i863.RegisterCubit(
          pickImageUseCase: await getAsync<_i967.StorageUseCase>(),
          authUseCase: await getAsync<_i1063.AuthUseCase>(),
        ));
    gh.factoryAsync<_i675.SplashController>(() async => _i675.SplashController(
          gh<_i439.LocalStorage>(),
          authUseCase: await getAsync<_i1063.AuthUseCase>(),
        ));
    gh.factoryAsync<_i299.GroupDetailCubit>(() async => _i299.GroupDetailCubit(
          await getAsync<_i652.PostUseCase>(),
          await getAsync<_i823.GroupUseCase>(),
        ));
    gh.factoryAsync<_i140.ChatUseCase>(() async =>
        _i140.ChatUseCase(repository: await getAsync<_i606.ChatRepository>()));
    gh.factoryAsync<_i301.CreateGroupChatCubit>(
        () async => _i301.CreateGroupChatCubit(
              await getAsync<_i967.StorageUseCase>(),
              await getAsync<_i140.ChatUseCase>(),
              gh<_i307.AppService>(),
            ));
    gh.factoryAsync<_i1004.ChatDetailCubit>(() async => _i1004.ChatDetailCubit(
          gh<_i307.AppService>(),
          await getAsync<_i140.ChatUseCase>(),
          await getAsync<_i967.StorageUseCase>(),
        ));
    gh.factoryAsync<_i290.CreateChatCubit>(() async => _i290.CreateChatCubit(
          await getAsync<_i967.StorageUseCase>(),
          await getAsync<_i140.ChatUseCase>(),
          gh<_i307.AppService>(),
          await getAsync<_i390.UserUseCase>(),
        ));
    gh.factoryAsync<_i299.ChatCubit>(() async => _i299.ChatCubit(
          await getAsync<_i140.ChatUseCase>(),
          gh<_i307.AppService>(),
        ));
    return this;
  }
}
