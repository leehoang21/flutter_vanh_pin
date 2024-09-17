part of 'my_page_cubit.dart';

@freezed
class MyPageState with _$MyPageState {
  const factory MyPageState(UserModel user, List<PostModel> posts) = _Loading;
}
