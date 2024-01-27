import 'package:flutter/widgets.dart';

class SideBarItem {
  const SideBarItem({
    required this.index,
    required this.name,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final int index;
  final String name;
  final String title;
  final Icon icon;
  final void Function(BuildContext) onTap;
}
