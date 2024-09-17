part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState(Map<int, List<PostModel>> posts) = _Loaded;
}
