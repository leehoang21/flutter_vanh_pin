part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState(List<PostModel> posts, List<UserModel> users) =
      _Loaded;
}
