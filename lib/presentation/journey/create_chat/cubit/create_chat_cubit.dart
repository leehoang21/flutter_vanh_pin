import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:pinpin/domain/use_cases/chat_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/domain/use_cases/user_use_case.dart';
import '../../../../domain/use_cases/storage_use_case.dart';
import '../../../bloc/base_bloc/base_bloc.dart';

part 'create_chat_state.dart';

@injectable
class CreateChatCubit extends BaseBloc<CreateChatState> {
  CreateChatCubit(
    this.storageUseCase,
    this.usecase,
    this.appService,
    this.userUseCase,
  ) : super(const CreateChatState(users: []));
  final StorageUseCase storageUseCase;
  final ChatUseCase usecase;
  final UserUseCase userUseCase;
  final AppService appService;
  List<UserModel> _users = [];
  UserModel? selectedUser;

  @override
  Future onInit() async {
    getUsers();
    super.onInit();
  }

  void getUsers() async {
    final users = await userUseCase.getAll();
    _users = users;
    _users.removeWhere((element) => element.uId == appService.state.user!.uId);
    emit(state.copyWith(users: _users));
  }

  void searchUser(String value) async {
    _users.where((element) => element.userName!.contains(value)).toList();
    emit(state.copyWith(users: _users));
  }
}
