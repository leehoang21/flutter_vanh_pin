import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinpin/common/assets/assets.gen.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/presentation/themes/themes.dart';
import 'package:pinpin/presentation/widgets/appbar_widget/appbar_widget.dart';
import 'package:pinpin/presentation/widgets/scaffold_wdiget/scaffold_widget.dart';
import '../../routers/app_router.dart';
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
              onTap: () {},
            ),
          ),
          _ItemSetting(
            item: ItemSettingModel(
              title: SettingsConstants.fingerprint.tr,
              onTap: () {},
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
