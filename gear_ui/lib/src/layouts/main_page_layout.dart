import 'package:flutter/material.dart';

// internal packages
import 'package:gear_ui/src/layouts/sidebar.dart';
import 'package:gear_ui/src/routes/app_route.dart';
import 'package:gear_ui/src/routes/app_routes.dart';

class MainPageLayout extends StatelessWidget {
  static const double _searchInputHeight = 40;

  const MainPageLayout({
    super.key,
    required this.body,
    this.selectedSideBarItem,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = false,
    this.primary = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.restorationId,
  });

  final AppRoute? selectedSideBarItem;
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final AlignmentDirectional persistentFooterAlignment;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final bool primary;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final String? restorationId;

  void _handleClickToCartButton(BuildContext context) {
    AppRoutes.cart.asDestination(
      context: context,
    );
  }

  void _handleClickToSearchInput(BuildContext context) {
    AppRoutes.search.asDestination(
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Widget searchInput = SizedBox(
      height: _searchInputHeight,
      child: TextField(
        readOnly: true,
        onTap: () {
          _handleClickToSearchInput(context);
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
            left: 15.0,
            top: 10.0,
            bottom: 10.0,
          ),
          hintText: "Search",
          suffixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_searchInputHeight / 2),
          ),
        ),
      ),
    );

    final Widget cartButton = IconButton(
      onPressed: () {
        _handleClickToCartButton(context);
      },
      icon: const Icon(
        Icons.shopping_cart_outlined,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        title: searchInput,
        centerTitle: true,
        actions: <Widget>[
          cartButton,
        ],
      ),
      drawer: SideBar(
        selectedItem: selectedSideBarItem,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      persistentFooterButtons: persistentFooterButtons,
      persistentFooterAlignment: persistentFooterAlignment,
      bottomSheet: bottomSheet,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      primary: primary,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      restorationId: restorationId,
    );
  }
}
