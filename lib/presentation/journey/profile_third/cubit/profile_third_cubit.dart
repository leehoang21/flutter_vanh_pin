import 'package:pinpin/data/models/friend_model.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/domain/use_cases/friend_use_case.dart';
import 'package:pinpin/domain/use_cases/user_use_case.dart';

import '../../../bloc/base_bloc/base_bloc.dart';

part 'profile_third_cubit.freezed.dart';
part 'profile_third_state.dart';

@injectable
class ProfileThirdCubit extends BaseBloc<ProfileThirdState> {
  final UserUseCase userUseCase;
  final FriendUseCase friendUseCase;
  late final String id;
  ProfileThirdCubit(this.userUseCase, this.friendUseCase)
      : super(const ProfileThirdState(UserModel()));

  @override
  initState(List params) {
    id = params[0] as String;
    init();
  }

  init() {
    getUser();
  }

  void getUser() async {
    final result = await userUseCase.get(id: id);
    if (result != null) {
      emit(state.copyWith(
        user: result,
      ));
    }
  }

  addFriend(UserModel? user) async {
    if (user != null) {
      await friendUseCase.addFriend(FriendModel(
        user: user,
        status: FriendStatus.pending,
      ));
    } else {
      await friendUseCase.addFriend(FriendModel(
        user: state.user,
        status: FriendStatus.pending,
      ));
    }
  }
}
