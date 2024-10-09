import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/common/constants/province.dart';
import 'package:pinpin/common/di/di.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/presentation/widgets/scaffold_wdiget/scaffold_widget.dart';

import '../../../../common/assets/assets.gen.dart';
import '../../../../common/constants/app_dimens.dart';
import '../../../../common/utils/formatter/mask_input_formatter.dart';
import '../../../../common/utils/validator.dart';
import '../../widgets/button_widget/text_button_widget.dart';
import '../../widgets/image_app_widget/image_app.dart';
import '../../widgets/pick_image/pick_image_widget.dart';
import '../../widgets/text_field_widget/select_field_widget.dart';
import '../../widgets/text_field_widget/text_field_widget.dart';
import 'cubit/edit_profile_cubit.dart';
import 'edit_profile_screen_contant.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _userNameController;
  late final TextEditingController _liveInController;
  late final TextEditingController _educationController;
  late final TextEditingController _jobController;
  late final UserModel user;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    user = getIt.get<AppService>().state.user!;
    _emailController = TextEditingController();
    _userNameController = TextEditingController();
    _phoneController = TextEditingController();
    _liveInController = TextEditingController();
    _educationController = TextEditingController();
    _jobController = TextEditingController();

    _emailController.text = user.email ?? '';
    _userNameController.text = user.userName ?? '';
    _phoneController.text = user.phoneNumber ?? '';
    _liveInController.text = user.address ?? '';
    _educationController.text = user.education ?? '';
    _jobController.text = user.job ?? '';
    context.read<EditProfileCubit>().initState([user.avatar]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () async {
                  await _pickImage(context);
                },
                child: ClipOval(
                  child: AppImageWidget(
                    width: 80.w,
                    height: 80.w,
                    fit: BoxFit.fill,
                    defultImage: Assets.images.defaultAvatar.image(),
                    path: context.watch<EditProfileCubit>().state.avatar,
                  ),
                ),
              ),
              SizedBox(
                height: AppDimens.height_32,
              ),
              TextFieldWidget(
                validate: AppValidator.validatePhoneNumber,
                inputFormatter: [MaskedInputFormatter('#### ### ###')],
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                hintText: EditProfileScreenContant.hintPhone.tr,
              ),
              SizedBox(
                height: AppDimens.height_12,
              ),
              TextFieldWidget(
                controller: _userNameController,
                hintText: EditProfileScreenContant.hintUserName.tr,
                validate: AppValidator.validateUseName,
              ),
              SizedBox(
                height: AppDimens.height_12,
              ),
              TextFieldWidget(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                enabled: false,
              ),
              SizedBox(
                height: AppDimens.height_16,
              ),
              SizedBox(
                height: 100.h,
                child: SelectFieldWidget(
                  items: [
                    for (var item in province.values)
                      SelectFieldModel(
                        label: item['name_with_type'] ?? '',
                        value: item['name_with_type'] ?? '',
                      ),
                  ],
                  selectedValue: user.address,
                  onChanged: (value) {
                    _liveInController.text = value ?? '';
                  },
                ),
              ),
              SizedBox(
                height: AppDimens.height_12,
              ),
              TextFieldWidget(
                controller: _educationController,
                hintText: EditProfileScreenContant.education.tr,
              ),
              SizedBox(
                height: AppDimens.height_12,
              ),
              TextFieldWidget(
                controller: _jobController,
                hintText: EditProfileScreenContant.job.tr,
              ),
              SizedBox(
                height: AppDimens.height_12,
              ),
              TextButtonWidget(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await edit(context);
                  }
                },
                title: 'Edit'.tr,
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> edit(BuildContext context) async {
    context.read<EditProfileCubit>().edit(
          userName: _userNameController.text,
          phoneNumber: _phoneController.text.replaceAll(' ', ''),
          liveIn: _liveInController.text,
          education: _educationController.text,
          job: _jobController.text,
        );
  }

  Future<void> _pickImage(BuildContext context) async {
    PickImageWidget(
      onPressed: (image) {
        context.read<EditProfileCubit>().addAvatar(image);
      },
    ).show(context);
  }
}
