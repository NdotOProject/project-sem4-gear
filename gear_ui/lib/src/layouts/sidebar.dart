import 'package:flutter/material.dart';

// internal packages
import 'package:gear_ui/src/features/auth/domain/signed_in_user.dart';
import 'package:gear_ui/src/routes/app_route.dart';
import 'package:gear_ui/src/routes/app_routes.dart';
import 'package:gear_ui/src/utils/assets_path.dart';
import 'package:gear_ui/src/widgets/image_widget.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
    this.selectedItem,
    this.headerImageName = "sidebar_image_1.jpg",
    this.headerTextColor = Colors.white,
    this.user,
  });

  final AppRoute? selectedItem;
  final String headerImageName;
  final Color headerTextColor;
  final SignedInUser? user;

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

  // sidebar item icon size
  static const double _sidebarItemIconSize = 40;

  // sidebar items
  List<_SideBarItem> get _items {
    final items = <_SideBarItem>[
      _SideBarItem(
        name: AppRoutes.home.name,
        title: "Home",
        icon: const Icon(Icons.home),
        onTap: (context) {
          AppRoutes.home.asDestination(
            context: context,
          );
        },
      ),
    ];

    if (user?.employee ?? false) {
      // TODO: add item of only customer
    } else {
      // TODO: add item of only employee
    }

    return items;
  }

  void _handleRedirectToSignIn(BuildContext context) {
    AppRoutes.signIn.asDestination(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Widget signedInHeaderContent = Column(
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
    );

    final Widget notSignedInHeaderContent = Center(
      child: ElevatedButton(
        onPressed: () {
          _handleRedirectToSignIn(context);
        },
        child: const Text(
          "Sign In",
        ),
      ),
    );

    final Widget sidebarHeader = DrawerHeader(
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
              _handleRedirectToSignIn(context);
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
                      ? signedInHeaderContent
                      : notSignedInHeaderContent,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          sidebarHeader,
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
                size: _sidebarItemIconSize,
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
    required this.name,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String name;
  final String title;
  final Icon icon;
  final void Function(BuildContext) onTap;
}
