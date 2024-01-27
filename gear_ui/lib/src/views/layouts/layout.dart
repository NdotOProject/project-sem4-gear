import 'package:flutter/material.dart';
import 'package:gear_ui/src/routes/app_route.dart';
import 'package:gear_ui/src/views/layouts/sidebar/sidebar.dart';
import 'package:gear_ui/src/views/layouts/sidebar/sidebar_item.dart';
import 'package:go_router/go_router.dart';

class Layout extends StatelessWidget {
  const Layout({
    super.key,
    required this.body,
    this.selectedSideBarItem = _defaultSelectedSideBarItem,
  });

  final Widget body;
  final AppRoutes selectedSideBarItem;

  static const _defaultSelectedSideBarItem = AppRoutes.home;

  static final List<SideBarItem> _sidebarItems = [
    SideBarItem(
      index: 0,
      name: AppRoutes.home.name,
      title: "Home",
      icon: const Icon(Icons.home),
      onTap: (context) {
        context.goNamed(AppRoutes.home.name);
      },
    ),
    SideBarItem(
      index: 1,
      name: AppRoutes.signIn.name,
      title: "Sign In",
      icon: const Icon(Icons.login),
      onTap: (context) {
        context.goNamed(AppRoutes.signIn.name);
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Gear"),
      ),
      drawer: SideBar(
        items: [
          ..._sidebarItems.map(
            (item) => ListTile(
              selected: selectedSideBarItem.name == item.name,
              title: Text(item.title),
              leading: item.icon,
              trailing: Icon(
                selectedSideBarItem.name == item.name
                    ? Icons.arrow_right_outlined
                    : Icons.arrow_left_outlined,
                weight: 100,
                size: 40,
              ),
              onTap: () {
                item.onTap.call(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
