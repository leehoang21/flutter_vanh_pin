import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/common/di/di.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/data/models/post_model.dart';
import 'package:pinpin/presentation/journey/home/cubit/home_cubit.dart';
import 'package:pinpin/presentation/themes/themes.dart';
import 'package:pinpin/presentation/widgets/appbar_widget/appbar_widget.dart';
import 'package:pinpin/presentation/widgets/button_widget/text_button_widget.dart';
import 'package:pinpin/presentation/widgets/image_app_widget/avatar_widget.dart';
import 'package:pinpin/presentation/widgets/text_field_widget/text_field_widget.dart';

class ShareWidget extends StatelessWidget {
  ShareWidget({super.key, required this.post});
  final TextEditingController controller = TextEditingController();
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBarWidget(
          action: Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: TextButtonWidget(
              height: 10.h,
              width: 20.w,
              title: 'share'.tr,
              onPressed: () async {
                final cubit = await getIt.getAsync<HomeCubit>();
                cubit.share(post, controller.text);
                Navigator.pop(context);
              },
            ),
          ),
          color: AppColor.fieldColor,
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 10.w,
              ),
              AvatarWidget(
                path: context.read<AppService>().state.user?.avatar,
                size: 40.sp,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                context.read<AppService>().state.user?.userName ?? '',
                style: ThemeText.caption,
              )
            ],
          ),
        ),
        TextFieldWidget(
          controller: controller,
          hintText: 'Please say something about this content'.tr,
          maxLines: 5,
        ),
        //padding keybroard
        SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom,
        ),
      ],
    );
  }
}
