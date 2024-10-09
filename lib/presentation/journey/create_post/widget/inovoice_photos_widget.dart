import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/presentation/journey/create_post/create_post_constants.dart';
import 'package:pinpin/presentation/journey/create_post/cubit/create_post_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../common/constants/app_dimens.dart';
import '../../../../../common/constants/layout_constants.dart';
import '../../../../common/assets/assets.gen.dart';
import '../../../themes/themes.dart';
import '../../../widgets/image_app_widget/image_app.dart';
import 'add_photo_button.dart';
import '../../../widgets/pick_image/pick_image_widget.dart';

class InvoicePhotosWidget extends StatefulWidget {
  const InvoicePhotosWidget({super.key});

  @override
  State<InvoicePhotosWidget> createState() => _InvoicePhotosWidgetState();
}

class _InvoicePhotosWidgetState extends State<InvoicePhotosWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Assets.images.colorCamera.image(),
            SizedBox(
              width: AppDimens.width_20,
            ),
            Text(
              CreatePostConstants.imgage.tr,
              style: ThemeText.caption
                  .copyWith(color: AppColor.tuna, fontWeight: FontWeight.w400),
            )
          ],
        ),
        SizedBox(
          height: AppDimens.height_8,
        ),
        BlocBuilder<CreatePostCubit, CreatePostState>(
            builder: (context, state) {
          final photos = state.images;
          final length = photos.length + 1;
          if (length == 1) {
            return AddPhotoButton(
              addPhoto: () {
                _addPhoto(context);
              },
            );
          }

          return SizedBox(
            height: 200.h,
            child: ListView(
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                for (int i = 0; i < length; i++)
                  (i == length - 1)
                      ? AddPhotoButton(
                          addPhoto: () {
                            _addPhoto(context);
                          },
                        )
                      : _Photo(photo: photos[i]),
              ],
            ),
          );
        })
      ],
    );
  }

  void _addPhoto(BuildContext context) {
    PickImageWidget(
      onPressed: (files) {
        final List<String> images = (files as List<File>)
            .map(
              (e) => e.path,
            )
            .toList();
        context.read<CreatePostCubit>().pickImage(images);
      },
    ).show(context);
  }
}

class _Photo extends StatelessWidget {
  const _Photo({
    required this.photo,
  });

  final String photo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(LayoutConstants.roundedRadius),
        ),
        child: AppImageWidget(
          path: photo,
          width: 1.sw / 3 - 20.w,
          height: 200.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
