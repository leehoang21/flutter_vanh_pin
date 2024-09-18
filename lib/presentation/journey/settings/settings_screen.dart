import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/presentation/themes/themes.dart';
import 'package:pinpin/presentation/widgets/appbar_widget/appbar_widget.dart';
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
    return SafeArea(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Theme.of(context).appBarTheme.backgroundColor),
        child: Scaffold(
          appBar: AppBarWidget(
            title: SettingsConstants.title.tr,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<SettingsCubit>().init();
            },
            child: ListView(
              children: [
                _ItemSetting(
                  item: ItemSettingModel(
                    title: 'hêlo',
                    onTap: () {
                      // context.read<SettingsCubit>().init();
                    },
                  ),
                ),
                _ItemSetting(
                    item: ItemSettingModel(
                  title: '',
                  color: AppColor.green,
                  onTap: () {
                    // context.read<SettingsCubit>().init();
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemSettingModel {
  final String title;
  final VoidCallback onTap;
  final Color color;

  ItemSettingModel({
    required this.title,
    required this.onTap,
    this.color = Colors.black,
  });
}

class _ItemSetting extends StatelessWidget {
  const _ItemSetting({super.key, required this.item});
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
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: item.color,
      ),
    );
  }
}
