part of 'settings_cubit.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState(UserModel user, List<PostModel> posts) = _Loading;
}
