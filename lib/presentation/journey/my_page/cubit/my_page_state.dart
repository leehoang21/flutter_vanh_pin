part of 'my_page_cubit.dart';

@freezed
class MyPageState with _$MyPageState {
  const factory MyPageState.loading(UserModel user) = _Loading;

  factory MyPageState.loaded(UserModel user) = _Loaded;
}
