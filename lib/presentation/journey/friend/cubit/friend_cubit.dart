import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/domain/use_cases/friend_use_case.dart';
import 'package:pinpin/domain/use_cases/user_use_case.dart';
import '../../../../../data/models/user_model.dart';
import '../../../../data/models/friend_model.dart';
import '../../../bloc/base_bloc/base_bloc.dart';

part 'friend_state.dart';

@injectable
class FriendCubit extends BaseBloc<FriendState> {
  final UserUseCase userUseCase;
  final AppService appService;
  final FriendUseCase friendUseCase;

  FriendCubit(
    this.appService,
    this.friendUseCase, {
    required this.userUseCase,
  }) : super(
          const FriendState([]),
        );
  @override
  onInit() {
    getUsers();
  }

  void getUsers() async {
    final users = await userUseCase.getAll();
    final user = appService.state.user;
    final friends = user?.friends ?? [];

    //remove current user and friends
    users.removeWhere((element) => element.uId == user?.uId);
    users.removeWhere(
      (element) => friends.any(
        (friend) => friend.user?.uId == element.uId,
      ),
    );
    emit(state.copyWith(users: users));
  }

  addFriend(UserModel? user) async {
    await friendUseCase.addFriend(FriendModel(
      user: user,
      status: FriendStatus.pending,
    ));
  }
}
