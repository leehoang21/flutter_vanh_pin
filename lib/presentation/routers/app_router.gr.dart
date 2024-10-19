// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ChatDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ChatDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChatDetailScreenProvider(
          key: args.key,
          model: args.model,
          members: args.members,
        ),
      );
    },
    ChatRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChatScreenProvider(),
      );
    },
    CommentRoute.name: (routeData) {
      final args = routeData.argsAs<CommentRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CommentScreenProvider(
          key: args.key,
          post: args.post,
        ),
      );
    },
    CreateChatRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateChatScreenProvider(),
      );
    },
    CreateGroupRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateGroupScreenProvider(),
      );
    },
    CreatePostRoute.name: (routeData) {
      final args = routeData.argsAs<CreatePostRouteArgs>(
          orElse: () => const CreatePostRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreatePostScreenProvider(
          key: args.key,
          group: args.group,
          post: args.post,
        ),
      );
    },
    EditProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EditProfileScreenProvider(),
      );
    },
    FriendRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FriendScreenProvider(),
      );
    },
    GroupDetailRoute.name: (routeData) {
      final args = routeData.argsAs<GroupDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: GroupDetailScreenProvider(
          key: args.key,
          groupModel: args.groupModel,
        ),
      );
    },
    GroupRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const GroupScreenProvider(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreenProvider(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreenProvider(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreenProvider(),
      );
    },
    MyPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MyPageScreenProvider(),
      );
    },
    NotificationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NotificationScreenProvider(),
      );
    },
    ProfileThirdRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileThirdRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProfileThirdScreenProvider(
          key: args.key,
          user: args.user,
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterScreenProvider(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreenProvider(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreenProvider(),
      );
    },
  };
}

/// generated route for
/// [ChatDetailScreenProvider]
class ChatDetailRoute extends PageRouteInfo<ChatDetailRouteArgs> {
  ChatDetailRoute({
    Key? key,
    required ChatModel model,
    required List<UserModel> members,
    List<PageRouteInfo>? children,
  }) : super(
          ChatDetailRoute.name,
          args: ChatDetailRouteArgs(
            key: key,
            model: model,
            members: members,
          ),
          initialChildren: children,
        );

  static const String name = 'ChatDetailRoute';

  static const PageInfo<ChatDetailRouteArgs> page =
      PageInfo<ChatDetailRouteArgs>(name);
}

class ChatDetailRouteArgs {
  const ChatDetailRouteArgs({
    this.key,
    required this.model,
    required this.members,
  });

  final Key? key;

  final ChatModel model;

  final List<UserModel> members;

  @override
  String toString() {
    return 'ChatDetailRouteArgs{key: $key, model: $model, members: $members}';
  }
}

/// generated route for
/// [ChatScreenProvider]
class ChatRoute extends PageRouteInfo<void> {
  const ChatRoute({List<PageRouteInfo>? children})
      : super(
          ChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CommentScreenProvider]
class CommentRoute extends PageRouteInfo<CommentRouteArgs> {
  CommentRoute({
    Key? key,
    required PostModel post,
    List<PageRouteInfo>? children,
  }) : super(
          CommentRoute.name,
          args: CommentRouteArgs(
            key: key,
            post: post,
          ),
          initialChildren: children,
        );

  static const String name = 'CommentRoute';

  static const PageInfo<CommentRouteArgs> page =
      PageInfo<CommentRouteArgs>(name);
}

class CommentRouteArgs {
  const CommentRouteArgs({
    this.key,
    required this.post,
  });

  final Key? key;

  final PostModel post;

  @override
  String toString() {
    return 'CommentRouteArgs{key: $key, post: $post}';
  }
}

/// generated route for
/// [CreateChatScreenProvider]
class CreateChatRoute extends PageRouteInfo<void> {
  const CreateChatRoute({List<PageRouteInfo>? children})
      : super(
          CreateChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateChatRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateGroupScreenProvider]
class CreateGroupRoute extends PageRouteInfo<void> {
  const CreateGroupRoute({List<PageRouteInfo>? children})
      : super(
          CreateGroupRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateGroupRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreatePostScreenProvider]
class CreatePostRoute extends PageRouteInfo<CreatePostRouteArgs> {
  CreatePostRoute({
    Key? key,
    GroupModel? group,
    PostModel? post,
    List<PageRouteInfo>? children,
  }) : super(
          CreatePostRoute.name,
          args: CreatePostRouteArgs(
            key: key,
            group: group,
            post: post,
          ),
          initialChildren: children,
        );

  static const String name = 'CreatePostRoute';

  static const PageInfo<CreatePostRouteArgs> page =
      PageInfo<CreatePostRouteArgs>(name);
}

class CreatePostRouteArgs {
  const CreatePostRouteArgs({
    this.key,
    this.group,
    this.post,
  });

  final Key? key;

  final GroupModel? group;

  final PostModel? post;

  @override
  String toString() {
    return 'CreatePostRouteArgs{key: $key, group: $group, post: $post}';
  }
}

/// generated route for
/// [EditProfileScreenProvider]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute({List<PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FriendScreenProvider]
class FriendRoute extends PageRouteInfo<void> {
  const FriendRoute({List<PageRouteInfo>? children})
      : super(
          FriendRoute.name,
          initialChildren: children,
        );

  static const String name = 'FriendRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [GroupDetailScreenProvider]
class GroupDetailRoute extends PageRouteInfo<GroupDetailRouteArgs> {
  GroupDetailRoute({
    Key? key,
    required GroupModel groupModel,
    List<PageRouteInfo>? children,
  }) : super(
          GroupDetailRoute.name,
          args: GroupDetailRouteArgs(
            key: key,
            groupModel: groupModel,
          ),
          initialChildren: children,
        );

  static const String name = 'GroupDetailRoute';

  static const PageInfo<GroupDetailRouteArgs> page =
      PageInfo<GroupDetailRouteArgs>(name);
}

class GroupDetailRouteArgs {
  const GroupDetailRouteArgs({
    this.key,
    required this.groupModel,
  });

  final Key? key;

  final GroupModel groupModel;

  @override
  String toString() {
    return 'GroupDetailRouteArgs{key: $key, groupModel: $groupModel}';
  }
}

/// generated route for
/// [GroupScreenProvider]
class GroupRoute extends PageRouteInfo<void> {
  const GroupRoute({List<PageRouteInfo>? children})
      : super(
          GroupRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreenProvider]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginScreenProvider]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreenProvider]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MyPageScreenProvider]
class MyPageRoute extends PageRouteInfo<void> {
  const MyPageRoute({List<PageRouteInfo>? children})
      : super(
          MyPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NotificationScreenProvider]
class NotificationRoute extends PageRouteInfo<void> {
  const NotificationRoute({List<PageRouteInfo>? children})
      : super(
          NotificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileThirdScreenProvider]
class ProfileThirdRoute extends PageRouteInfo<ProfileThirdRouteArgs> {
  ProfileThirdRoute({
    Key? key,
    required UserModel? user,
    List<PageRouteInfo>? children,
  }) : super(
          ProfileThirdRoute.name,
          args: ProfileThirdRouteArgs(
            key: key,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileThirdRoute';

  static const PageInfo<ProfileThirdRouteArgs> page =
      PageInfo<ProfileThirdRouteArgs>(name);
}

class ProfileThirdRouteArgs {
  const ProfileThirdRouteArgs({
    this.key,
    required this.user,
  });

  final Key? key;

  final UserModel? user;

  @override
  String toString() {
    return 'ProfileThirdRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [RegisterScreenProvider]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsScreenProvider]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashScreenProvider]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
