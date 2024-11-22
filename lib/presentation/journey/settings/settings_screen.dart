import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/common/assets/assets.gen.dart';
import 'package:pinpin/common/di/di.dart';
import 'package:pinpin/common/extension/show_extension.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/presentation/journey/settings/widget/google_authenticator.dart';
import 'package:pinpin/presentation/themes/themes.dart';
import 'package:pinpin/presentation/widgets/appbar_widget/appbar_widget.dart';
import 'package:pinpin/presentation/widgets/scaffold_wdiget/scaffold_widget.dart';
import '../../../common/enums/login_type.dart';
import '../../../common/utils/validator.dart';
import '../../routers/app_router.dart';
import '../../widgets/button_widget/text_button_widget.dart';
import '../../widgets/text_field_widget/text_field_widget.dart';
import '../auth/login/login_constants.dart';
import '../auth/login/widget/login_with_item.dart';
import '../auth/widgets/auth_scaffold/devider_text_widget.dart';
import 'cubit/settings_cubit.dart';
import 'settings_constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appbar: AppBarWidget(
        title: SettingsConstants.title.tr,
      ),
      body: ListView(
        children: [
          _ItemSetting(
            item: ItemSettingModel(
              title: SettingsConstants.editAccont.tr,
              onTap: () {
                context.pushRoute(const EditProfileRoute());
              },
            ),
          ),
          _ItemSetting(
            item: ItemSettingModel(
              title: SettingsConstants.changePassword.tr,
              onTap: () async {
                await context.showBottomSheet(
                  child: SizedBox(
                    height: 0.6.sh,
                    child: const _ReloginWidget(),
                  ),
                );
                final credential = context.read<AppService>().state.credential;
                if (credential != null) {
                  await context.showBottomSheet(
                    child: SizedBox(
                      height: 0.6.sh,
                      child: _ChagePassWidget(
                        cubit: context.read<SettingsCubit>(),
                      ),
                    ),
                  );
                  setState(() {});
                  context.read<AppService>().setCredential(null);
                }
              },
            ),
          ),
          _ItemSetting(
            item: ItemSettingModel(
              title: SettingsConstants.biometric.tr,
              onTap: () {},
              icon: CupertinoSwitch(
                value: context.watch<SettingsCubit>().state.isRegisterBiometric,
                onChanged: (value) async {
                  if (value) {
                    await context.showBottomSheet(
                      child: SizedBox(
                        height: 0.6.sh,
                        child: const _ReloginWidget(),
                      ),
                    );
                    final credential =
                        context.read<AppService>().state.credential;
                    if (credential != null) {
                      await context.read<SettingsCubit>().registerBiometric();
                      setState(() {});
                      context.read<AppService>().setCredential(null);
                    }
                  } else {
                    context.read<SettingsCubit>().unRegisterBiometric();
                  }
                },
              ),
            ),
          ),
          _ItemSetting(
            item: ItemSettingModel(
              title: SettingsConstants.authApp.tr,
              onTap: () {},
              icon: CupertinoSwitch(
                value:
                    context.watch<AppService>().state.user?.isAuthenticator ??
                        false,
                onChanged: (value) async {
                  final result = await context
                      .read<SettingsCubit>()
                      .registerGoogleAuthenticator(value);
                  if (result != null) {
                    context.showBottomSheet(
                      child: SizedBox(
                        height: 0.6.sh,
                        child: GoogleAuthenticatorQrWidget(
                          content: result,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          _ItemSetting(
            item: ItemSettingModel(
              title: SettingsConstants.friends.tr,
              onTap: () {
                context.pushRoute(const FriendRoute());
              },
            ),
          ),
          _ItemSetting(
            item: ItemSettingModel(
              icon: Assets.icons.logout.svg(
                  width: 20,
                  height: 20,
                  colorFilter:
                      const ColorFilter.mode(Colors.orange, BlendMode.srcIn)),
              title: SettingsConstants.logout,
              color: Colors.orange,
              onTap: () {
                context.read<SettingsCubit>().logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ItemSettingModel {
  final String title;
  final VoidCallback onTap;
  final Color color;
  final Widget icon;

  ItemSettingModel({
    required this.title,
    required this.onTap,
    this.color = Colors.black,
    this.icon = const Icon(
      Icons.arrow_forward_ios,
      color: Colors.black,
    ),
  });
}

class _ItemSetting extends StatelessWidget {
  const _ItemSetting({required this.item});
  final ItemSettingModel item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item.title,
        style: ThemeText.caption.copyWith(
          color: item.color,
        ),
      ),
      onTap: item.onTap,
      trailing: item.icon,
    );
  }
}

class _ReloginWidget extends StatefulWidget {
  const _ReloginWidget();

  @override
  State<_ReloginWidget> createState() => _ReloginWidgetState();
}

class _ReloginWidgetState extends State<_ReloginWidget> {
  final TextEditingController controller = TextEditingController();

  final TextEditingController controllerPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();
  late final SettingsCubit cubit;

  @override
  void initState() {
    getIt.getAsync<SettingsCubit>().then((value) {
      cubit = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: LoginConstants.distanceTextToField),
                  child: TextFieldWidget(
                    controller: controller,
                    hintText: LoginConstants.hintEmail,
                    validate: AppValidator.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    textStyle: ThemeText.style14Medium
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: LoginConstants.distanceTextToField),
                  child: SecurityTextFieldWidget(
                    controller: controllerPassword,
                    keyboardType: TextInputType.text,
                    validate: AppValidator.validatePassword,
                    hintText: LoginConstants.yourPassword,
                    textStyle: ThemeText.style14Medium
                        .copyWith(fontWeight: FontWeight.normal),
                    onEditingComplete: () {
                      final currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus &&
                          currentFocus.focusedChild != null) {
                        FocusManager.instance.primaryFocus!.unfocus();
                      }
                      if (formKey.currentState!.validate()) {
                        cubit.login(
                          LoginType.password,
                          email: controller.text,
                          password: controllerPassword.text,
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: LoginConstants.distanceButtonToField,
                  ),
                  child: TextButtonWidget(
                    onPressed: () async {
                      final currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus &&
                          currentFocus.focusedChild != null) {
                        FocusManager.instance.primaryFocus!.unfocus();
                      }
                      if (formKey.currentState!.validate()) {
                        cubit.login(
                          LoginType.password,
                          email: controller.text,
                          password: controllerPassword.text,
                        );
                      }
                    },
                    title: LoginConstants.signIn,
                  ),
                ),
              ],
            ),
            const DeviderTextWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ItemLoginWithWidget(
                    data: ItemLoginWithModel(
                  icon: Assets.icons.icGoogle.svg(
                    width: 28.w,
                    height: 28.w,
                  ),
                  onPressed: () {
                    cubit.login(LoginType.google);
                  },
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ChagePassWidget extends StatelessWidget {
  _ChagePassWidget({super.key, required this.cubit});

  final TextEditingController controller = TextEditingController();

  final TextEditingController controllerPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final SettingsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: LoginConstants.distanceTextToField),
                  child: SecurityTextFieldWidget(
                    controller: controller,
                    keyboardType: TextInputType.text,
                    validate: AppValidator.validatePassword,
                    hintText: 'New Password'.tr,
                    textStyle: ThemeText.style14Medium
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: LoginConstants.distanceTextToField),
                  child: SecurityTextFieldWidget(
                    controller: controllerPassword,
                    keyboardType: TextInputType.text,
                    validate: (pass) {
                      if (pass != controller.text) {
                        return "Password not match".tr;
                      }
                      return null;
                    },
                    hintText: 'Confirm Password'.tr,
                    textStyle: ThemeText.style14Medium
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: LoginConstants.distanceButtonToField,
                  ),
                  child: TextButtonWidget(
                    onPressed: () async {
                      final currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus &&
                          currentFocus.focusedChild != null) {
                        FocusManager.instance.primaryFocus!.unfocus();
                      }
                      if (formKey.currentState!.validate()) {
                        cubit.changePass(controller.text);
                      }
                    },
                    title: 'Change Password'.tr,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
