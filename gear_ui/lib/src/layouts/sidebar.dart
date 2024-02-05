import 'package:flutter/material.dart';

// internal packages
import 'package:gear_ui/src/common/widgets/image_widget.dart';
import 'package:gear_ui/src/features/auth/domain/user.dart';
import 'package:gear_ui/src/routes/app_router.dart';
import 'package:gear_ui/src/utils/assets_path.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
    this.selectedItem,
    this.headerImageName = "sidebar_image_1.jpg",
    this.headerTextColor = Colors.white,
    this.user,
  });

  final AppRoutes? selectedItem;
  final String headerImageName;
  final Color headerTextColor;
  final User? user;

  // header settings
  static const EdgeInsets _headerPadding = EdgeInsets.only(left: 10.0);

  // header avatar settings
  static const double _avatarSize = 40.0;
  static const double _avatarBorderWidth = 5.0;
  static const String _fallbackAvatarName = "unknown_user.jpg";

  // header text settings
  static const EdgeInsets _textSectionPadding = EdgeInsets.all(10.0);
  static const double _usernameFontSize = 20.0;
  static const double _emailFontSize = 14.0;

  // sidebar items
  List<_SideBarItem> get _items {
    final items = <_SideBarItem>[
      _SideBarItem(
        index: 0,
        name: AppRoutes.home.name,
        title: "Home",
        icon: const Icon(Icons.home),
        onTap: (context) {
          AppRouter.redirectTo(
            context: context,
            route: AppRoutes.home,
          );
        },
      ),
      // SideBarItem(
      //   index: 1,
      //   name: AppRoutes.signIn.name,
      //   title: "Sign In",
      //   icon: const Icon(Icons.login),
      //   onTap: (context) {
      //     context.pushNamed(AppRoutes.signIn.name);
      //   },
      // ),
    ];

    if (user?.employee ?? false) {
    } else {}

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  AssetsPath.sidebarImage(headerImageName),
                ),
              ),
            ),
            child: Padding(
              padding: _headerPadding,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if (user == null) {
                    AppRouter.redirectTo(
                      context: context,
                      route: AppRoutes.signIn,
                    );
                  } else {
                    // TODO: send to user detail page.
                  }
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: _avatarSize,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(_avatarBorderWidth),
                        child: ClipOval(
                          child: ImageWidget(
                            imageUrl: user?.avatar,
                            fallbackImage: Image.asset(
                              AssetsPath.fallbackImage(_fallbackAvatarName),
                              fit: BoxFit.cover,
                            ),
                            height: _avatarSize * 2,
                            width: _avatarSize * 2,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: _textSectionPadding,
                        child: user != null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user?.name ?? "",
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: headerTextColor,
                                      fontSize: _usernameFontSize,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    user?.email ?? "",
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: headerTextColor,
                                      fontSize: _emailFontSize,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    AppRouter.redirectTo(
                                      context: context,
                                      route: AppRoutes.signIn,
                                    );
                                  },
                                  child: const Text(
                                    "Sign In",
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ..._items.map((item) {
            final bool isSelected = item.name == selectedItem?.name;
            return ListTile(
              selected: isSelected,
              title: Text(item.title),
              leading: item.icon,
              trailing: Icon(
                isSelected
                    ? Icons.arrow_right_outlined
                    : Icons.arrow_left_outlined,
                weight: 100,
                size: 40,
              ),
              onTap: () {
                item.onTap(context);
              },
            );
          }),
        ],
      ),
    );
  }
}

class _SideBarItem {
  const _SideBarItem({
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
