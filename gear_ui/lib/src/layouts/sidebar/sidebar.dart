import 'package:flutter/material.dart';
import 'package:gear_ui/src/common/widgets/image_widget.dart';
import 'package:gear_ui/src/features/auth/domain/user.dart';
import 'package:gear_ui/src/routes/app_route.dart';
import 'package:gear_ui/src/utils/assets_paths.dart';
import 'package:go_router/go_router.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
    this.items = _emptyItems,
    this.headerImageName = "sidebar_image_1.jpg",
    this.headerTextColor = Colors.white,
    this.user,
  });

  final List<Widget> items;
  final String headerImageName;
  final Color headerTextColor;
  final User? user;

  // default values
  static const List<Widget> _emptyItems = <Widget>[];

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
                  Assets.sidebarImage(headerImageName),
                ),
              ),
            ),
            child: Padding(
              padding: _headerPadding,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if (user == null) {
                    context.goNamed(AppRoutes.signIn.name);
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
                            imageUrl: user?.avatar ?? "",
                            fallbackImage: Image.asset(
                              Assets.fallbackImage(_fallbackAvatarName),
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
                        child: Column(
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ...items,
        ],
      ),
    );
  }
}
