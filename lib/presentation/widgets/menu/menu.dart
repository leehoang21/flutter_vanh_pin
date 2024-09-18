import 'package:flutter/cupertino.dart';

class MenuModel {
  final String title;
  final IconData? icon;
  final Function() onTap;

  MenuModel({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    required this.menus,
    required this.child,
  });
  final List<MenuModel> menus;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu(
      actions: [
        for (final menu in menus)
          CupertinoContextMenuAction(
            onPressed: menu.onTap,
            child: Row(
              children: [
                if (menu.icon != null) Icon(menu.icon),
                Text(menu.title),
              ],
            ),
          ),
      ],
      child: child,
    );
  }
}
