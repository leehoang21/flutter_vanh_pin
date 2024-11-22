import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinpin/common/assets/assets.gen.dart';
import 'package:pinpin/common/extension/show_extension.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/data/models/group_model.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:pinpin/presentation/journey/group_detail/widget/add_member_widget.dart';
import 'package:pinpin/presentation/themes/themes.dart';
import 'package:pinpin/presentation/widgets/appbar_widget/appbar_widget.dart';
import 'package:pinpin/presentation/widgets/card_widget/post_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/presentation/widgets/scaffold_wdiget/scaffold_widget.dart';
import '../../../common/enums/app_enums.dart';
import '../../../common/utils/pick_image.dart';
import '../../../data/models/friend_model.dart';
import '../../widgets/button_widget/icon_button_widget.dart';
import '../../widgets/button_widget/text_button_widget.dart';
import '../../widgets/image_app_widget/image_app.dart';
import 'cubit/detail_group_cubit.dart';
import 'group_detail_constants.dart';
import 'widget/create_post_group_widget.dart';

class GroupDetailScreen extends StatefulWidget {
  const GroupDetailScreen({Key? key}) : super(key: key);

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final model = context.read<GroupDetailCubit>().state.model;
    final bool isMember =
        model.author?.uId == context.read<AppService>().state.user?.uId ||
            (model.memberIds ?? [])
                .contains(context.read<AppService>().state.user?.uId);
    return ScaffoldWidget(
      padding: EdgeInsets.zero,
      appbar: AppBarWidget(
        title: isMember ? model.name : 'Join group'.tr,
        action: isMember
            ? IconButton(
                onPressed: () async {
                  await context.showBottomSheet(
                    child: SizedBox(
                      height: 0.8.sh,
                      child: _MoreWidget(
                        context.read<GroupDetailCubit>(),
                      ),
                    ),
                  );
                  setState(() {});
                },
                icon: Assets.icons.navbarTrailingIcon.svg(),
              )
            : const SizedBox(),
      ),
      body: isMember
          ? Column(
              children: [
                _WallPaperAndAvatarWidget(
                    model.background ?? '',
                    model.avatar ?? '',
                    false,
                    context.read<GroupDetailCubit>()),
                Expanded(
                  child: _Screen(
                    model: model,
                    isMember: isMember,
                  ),
                ),
              ],
            )
          : model.type == GroupType.public
              ? Column(
                  children: [
                    _WallPaperAndAvatarWidget(
                        model.background ?? '',
                        model.avatar ?? '',
                        false,
                        context.read<GroupDetailCubit>()),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: TextButtonWidget(
                        onPressed: () {
                          context.read<GroupDetailCubit>().joinGroup('');
                        },
                        width: 0.5.sw,
                        title: GroupDetailConstants.joinGroup.tr,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Expanded(
                        child: _Screen(
                      model: model,
                      isMember: isMember,
                    )),
                  ],
                )
              : Column(
                  children: [
                    _WallPaperAndAvatarWidget(
                        model.background ?? '',
                        model.avatar ?? '',
                        false,
                        context.read<GroupDetailCubit>()),
                    SizedBox(
                      height: 20.h,
                    ),
                    _JoinGroupScreen(
                      model: model,
                    ),
                  ],
                ),
    );
  }
}

class _JoinGroupScreen extends StatelessWidget {
  final GroupModel model;

  const _JoinGroupScreen({required this.model});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            model.name ?? '',
            style: ThemeText.body2,
          ),
          SizedBox(
            height: 10.h,
          ),
          TextButtonWidget2(
            onPressed: () {
              context.read<GroupDetailCubit>().joinGroup('');
            },
            title: GroupDetailConstants.joinGroup.tr,
          ),
        ],
      ),
    );
  }
}

class _Screen extends StatelessWidget {
  const _Screen({
    required this.isMember,
    required this.model,
  });
  final bool isMember;
  final GroupModel model;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<GroupDetailCubit>().init();
      },
      child: ListView(
        children: [
          if (isMember)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  const CreatePostGroupWidget(),
                ],
              ),
            ),
          SizedBox(
            height: 20.h,
          ),
          BlocBuilder<GroupDetailCubit, GroupDetailState>(
            builder: (context, state) {
              return Column(
                children: state.posts
                    .map(
                      (e) => PostCard(
                        model: e,
                      ),
                    )
                    .toList(),
              );
            },
          )
        ],
      ),
    );
  }
}

class _MoreWidget extends StatelessWidget {
  const _MoreWidget(this.bloc);
  final GroupDetailCubit bloc;

  @override
  Widget build(BuildContext context) {
    final model = bloc.state.model;
    final bool isAuthor =
        model.author?.uId == context.read<AppService>().state.user?.uId;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _WallPaperAndAvatarWidget(
            model.background ?? '', model.avatar ?? '', true, bloc),
        SizedBox(
          height: 12.h,
        ),
        Center(
          child: Text(
            model.name ?? '',
            style: ThemeText.body2,
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconPostButtonWidget(
                title: GroupDetailConstants.addMembers.tr,
                textStyle: ThemeText.body2,
                onPressed: () {
                  context.showBottomSheet(
                    child: AddMemberWidget(
                      users: memberAdd(context, bloc.state.model),
                      onChanged: (value) {
                        bloc.addMembers(value);
                      },
                      title: 'Add members',
                      titleButton: 'Add',
                    ),
                  );
                },
                icon: const Icon(Icons.person_add),
              ),
              IconPostButtonWidget(
                title: GroupDetailConstants.addMembers.tr,
                textStyle: ThemeText.body2,
                onPressed: () {
                  context.showBottomSheet(
                    child: AddMemberWidget(
                      users: memberRemove(context, bloc.state.model),
                      onChanged: (value) {
                        bloc.removeMembers(value);
                      },
                      title: 'Remove members',
                      titleButton: 'Remove',
                    ),
                  );
                },
                icon: const Icon(Icons.person_remove),
              ),
              IconPostButtonWidget(
                title: GroupDetailConstants.addMembers.tr,
                textStyle: ThemeText.body2,
                onPressed: () {
                  context.showBottomSheet(
                    child: AddMemberWidget(
                      users: memberAll(context, bloc.state.model),
                      onChanged: (value) {
                        bloc.addMembers(value);
                      },
                      title: 'All members',
                      titleButton: '',
                    ),
                  );
                },
                icon: const Icon(Icons.people_sharp),
              ),
              IconPostButtonWidget(
                title: isAuthor ? 'Delete'.tr : 'Leave'.tr,
                textStyle: ThemeText.body2,
                onPressed: () {
                  if (isAuthor) {
                    bloc.delete();
                  } else {
                    bloc.leave();
                  }
                },
                icon: Assets.icons.trash.svg(
                  height: 30.sp,
                  width: 30.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<UserModel> memberAdd(BuildContext context, GroupModel model) {
    List<FriendModel> friends =
        context.read<AppService>().state.user?.friends ?? [];
    final members = model.members;
    for (final member in members!) {
      friends =
          friends.where((element) => element.user?.uId != member.uId).toList();
    }
    return friends.map((e) => e.user ?? const UserModel()).toList();
  }

  List<UserModel> memberRemove(BuildContext context, GroupModel model) {
    List<FriendModel> friends =
        context.read<AppService>().state.user?.friends ?? [];
    final members = model.members;
    for (final member in members!) {
      friends =
          friends.where((element) => element.user?.uId == member.uId).toList();
    }
    return friends.map((e) => e.user ?? const UserModel()).toList();
  }

  List<UserModel> memberAll(BuildContext context, GroupModel model) {
    final users = [
      context.read<AppService>().state.user!,
      ...model.members ?? <UserModel>[]
    ];
    return users;
  }
}

class _WallPaperAndAvatarWidget extends StatelessWidget {
  const _WallPaperAndAvatarWidget(
      this.wallPaperUrl, this.avatarUrl, this.isUpdate, this.cubit);
  final String wallPaperUrl;
  final String avatarUrl;
  final bool isUpdate;
  final GroupDetailCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (160 + (80.sp / 2)).h,
      width: 1.sw,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                if (!isUpdate) return;
                final PickImage pickImage = PickImage();
                pickImage.pickImage(source: ImageSource.gallery).then((value) {
                  if (value != null) {
                    cubit.updateAvatar(null, value);
                  }
                });
              },
              child: AppImageWidget(
                path: wallPaperUrl,
                fit: BoxFit.cover,
                height: 160.h,
                width: 1.sw,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 40.sp,
            height: 80.sp,
            width: 80.sp,
            child: InkWell(
              onTap: () {
                if (!isUpdate) return;
                final PickImage pickImage = PickImage();
                pickImage.pickImage(source: ImageSource.gallery).then((value) {
                  if (value != null) {
                    cubit.updateAvatar(value, null);
                  }
                });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.sp),
                child: AppImageWidget(
                  path: avatarUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
