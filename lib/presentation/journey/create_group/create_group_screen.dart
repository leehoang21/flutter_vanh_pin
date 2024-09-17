import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/common/enums/app_enums.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/presentation/widgets/text_field_widget/text_field_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/constants/app_dimens.dart';
import '../../../common/constants/layout_constants.dart';
import '../../widgets/appbar_widget/appbar_widget.dart';
import '../../widgets/button_widget/text_button_widget.dart';
import '../../widgets/image_app_widget/image_app.dart';
import '../../widgets/scaffold_wdiget/scaffold_widget.dart';
import '../../widgets/text_field_widget/select_field_widget.dart';
import 'create_group_constants.dart';
import 'cubit/create_group_cubit.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _nameController = TextEditingController();
  GroupType? _groupType;
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      padding: EdgeInsets.zero,
      appbar: AppBarWidget(
        title: CreateGroupConstants.title.tr,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CreateGroupCubit>().onInit();
        },
        child: Column(
          children: [
            const _WallPaperAndAvatarWidget(
              'https://cellphones.com.vn/sforum/wp-content/uploads/2024/02/anh-thien-nhien-1.jpg',
              'https://cellphones.com.vn/sforum/wp-content/uploads/2024/02/anh-thien-nhien-1.jpg',
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                      horizontal: LayoutConstants.paddingHorizontalApp)
                  .copyWith(bottom: LayoutConstants.paddingVerticalApp),
              child: Column(
                children: [
                  SizedBox(
                    height: AppDimens.height_12,
                  ),
                  TextFieldWidget(
                    controller: _nameController,
                    hintText: CreateGroupConstants.nameGroup,
                  ),
                  SizedBox(
                    height: AppDimens.height_12,
                  ),
                  SizedBox(
                    height: 50.h,
                    child: SelectFieldWidget(
                      onChanged: (value) {
                        _groupType = value;
                      },
                      hintText: CreateGroupConstants.groupType,
                      items: GroupType.values
                          .map((e) => SelectFieldModel(
                              label: e.name.toTitleCase, value: e))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            TextButtonWidget(
              onPressed: () {
                context.read<CreateGroupCubit>().createGroup(
                    _nameController.text, _groupType ?? GroupType.public);
              },
              title: CreateGroupConstants.create.tr,
            ),
          ],
        ),
      ),
    );
  }
}

class _WallPaperAndAvatarWidget extends StatelessWidget {
  const _WallPaperAndAvatarWidget(this.wallPaperUrl, this.avatarUrl);
  final String wallPaperUrl;
  final String avatarUrl;

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
              onTap: () {},
              child: AppImageWidget(
                path: wallPaperUrl,
                fit: BoxFit.fill,
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.sp),
              child: AppImageWidget(
                path: avatarUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
