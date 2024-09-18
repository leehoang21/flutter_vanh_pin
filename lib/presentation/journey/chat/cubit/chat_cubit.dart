import 'dart:async';
import 'package:pinpin/data/models/chat_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/domain/use_cases/chat_use_case.dart';

import '../../../bloc/base_bloc/base_bloc.dart';

part 'chat_cubit.freezed.dart';
part 'chat_state.dart';

@injectable
class ChatCubit extends BaseBloc<ChatState> {
  ChatCubit(this.useCase)
      : super(
          const ChatState(
            [],
          ),
        );
  StreamSubscription? _subscription;
  final ChatUseCase useCase;

  @override
  Future onInit() async {
    get();
    super.onInit();
  }

  void get() {
    _subscription?.cancel();
    _subscription = useCase.get().listen((event) {
      event.fold(
        (value) {
          emit(ChatState(value));
        },
        (error) {
          emit(const ChatState([]));
        },
      );
    });
  }
}
