import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:pinpin/common/enums/app_enums.dart';
import 'package:pinpin/common/extension/bloc_extension.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/data/models/group_model.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:pinpin/domain/use_cases/group_use_case.dart';
import 'package:pinpin/domain/use_cases/post_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/domain/use_cases/storage_use_case.dart';

import '../../../../common/configs/default_environment.dart';
import '../../../../data/models/post_model.dart';
import '../../../bloc/base_bloc/base_bloc.dart';

part 'detail_group_state.dart';

@injectable
class GroupDetailCubit extends BaseBloc<GroupDetailState> {
  GroupDetailCubit(
      this.postUseCase, this.groupUseCase, this.appService, this.storageUseCase)
      : super(const GroupDetailState([], GroupModel()));
  final PostUseCase postUseCase;
  final GroupUseCase groupUseCase;
  final AppService appService;
  final StorageUseCase storageUseCase;
  StreamSubscription _postSubscription = const Stream.empty().listen((_) {});
  StreamSubscription _groupDetailSubscription =
      const Stream.empty().listen((_) {});

  @override
  initState(List params) {
    final data = params[0] as GroupModel;
    emit(state.copyWith(model: data));
    init();
  }

  init() {
    getPostToGroup();
  }

  @override
  Future<void> close() {
    _postSubscription.cancel();
    return super.close();
  }

  Future<void> getPostToGroup() async {
    _postSubscription.cancel();

    final result = postUseCase.getToGroup([state.model.uId ?? '']);
    _postSubscription = result.listen((event) {
      event.fold(
        (futurePosts) async {
          final posts = <PostModel>[];
          for (final post in futurePosts) {
            posts.add(await post);
          }
          //
          emit(state.copyWith(posts: posts));
        },
        (error) {
          showSnackbar(translationKey: error.message);
        },
      );
    });
  }

  getDetail() {
    _groupDetailSubscription.cancel();
    final result = groupUseCase.getDetail(state.model.uId ?? '');
    _groupDetailSubscription = result.listen((event) {
      event.fold(
        (model) {
          emit(state.copyWith(model: model));
        },
        (error) {
          showSnackbar(translationKey: error.message);
        },
      );
    });
  }

  joinGroup(String content) async {
    if (state.model.type == GroupType.public) {
      await groupUseCase.joinGroup(appService.state.user!,
          state.model.uId ?? '', state.model.type!, content);
    } else {
      await groupUseCase.joinGroup(state.model.author!, state.model.uId ?? '',
          state.model.type!, content);
    }

    pop('');
  }

  addMembers(List<UserModel> users) async {
    for (final user in users) {
      await groupUseCase.addMembers(
          user, state.model.uId ?? '', state.model.type!);
      emit(state.copyWith(
          model: state.model.copyWith(members: [
        ...state.model.members ?? [],
        user,
      ])));
    }
    pop('');
  }

  removeMembers(List<UserModel> users) async {
    for (final user in users) {
      await groupUseCase.removeMembers(
          user, state.model.uId ?? '', state.model.type!);
      final members = state.model.members
              ?.where(
                (element) => element.uId != user.uId,
              )
              .toList() ??
          [];
      emit(state.copyWith(model: state.model.copyWith(members: members)));
    }
    pop('');
  }

  updateAvatar(File? avatar, File? background) async {
    String avatarUrl = '';
    String backgroundUrl = '';
    //avatar
    if (avatar != null) {
      final String storagePath =
          '${DefaultEnvironment.images}/${DateTime.now().millisecondsSinceEpoch}';
      final result = await storageUseCase.put(
        imageToUpload: avatar,
        imagePathStorage: storagePath,
      );
      result.fold(
        (url) {
          avatarUrl = url;
        },
        (error) => showSnackbar(translationKey: error.toString()),
      );
    }
    //background
    if (background != null) {
      final String storagePath =
          '${DefaultEnvironment.images}/${DateTime.now().millisecondsSinceEpoch}';
      final result = await storageUseCase.put(
        imageToUpload: background,
        imagePathStorage: storagePath,
      );
      result.fold(
        (url) {
          backgroundUrl = url;
        },
        (error) => showSnackbar(translationKey: error.toString()),
      );
    }
    //

    final error = await groupUseCase.update(
        avatarUrl, backgroundUrl, state.model.uId ?? '');
    if (error != null) {
      showSnackbar(translationKey: error.toString());
    } else {
      emit(state.copyWith(
        model: state.model.copyWith(
          avatar: isNullEmpty(avatarUrl) ? state.model.avatar : avatarUrl,
          background: isNullEmpty(backgroundUrl)
              ? state.model.background
              : backgroundUrl,
        ),
      ));
      await pop('');
    }
    hideLoading();
  }

  leave() async {
    final error = await groupUseCase.leave(
        UserModel(
          uId: appService.state.user!.uId,
          userName: appService.state.user!.userName,
          avatar: appService.state.user!.avatar,
        ),
        state.model.uId ?? '');
    if (error != null) {
      showSnackbar(translationKey: error.toString());
    } else {
      await pop('');
      pop('');
    }
  }

  delete() async {
    final error = await groupUseCase.delete(state.model.uId ?? '');
    if (error != null) {
      showSnackbar(translationKey: error.toString());
    } else {
      await pop('');
      pop('');
    }
  }
}
