import 'package:flutter/material.dart';

// internal packages
import 'package:gear_ui/src/layouts/sidebar.dart';
import 'package:gear_ui/src/routes/app_route.dart';
import 'package:gear_ui/src/routes/app_routes.dart';

class MainPageLayout extends StatelessWidget {
  const MainPageLayout({
    super.key,
    required this.body,
    this.selectedSideBarItem,
  });

  final Widget body;
  final AppRoute? selectedSideBarItem;

  // search input size
  static const double _searchInputHeight = 40;

  void _redirectToCartPage(BuildContext context) {
    AppRoutes.cart.asDestination(
      context: context,
    );
  }

  void _redirectToSearchPage(BuildContext context) {
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
          _redirectToSearchPage(context);
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
        _redirectToCartPage(context);
      },
      icon: const Icon(
        Icons.shopping_cart_outlined,
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        centerTitle: true,
        title: searchInput,
        actions: <Widget>[
          cartButton,
        ],
      ),
      drawer: SideBar(
        selectedItem: selectedSideBarItem,
      ),
      body: body,
    );
  }
}
