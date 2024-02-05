import 'package:flutter/material.dart';

// internal packages
import 'package:gear_ui/src/layouts/sidebar.dart';
import 'package:gear_ui/src/routes/app_router.dart';

class MainPageLayout extends StatelessWidget {
  const MainPageLayout({
    super.key,
    required this.body,
    this.selectedSideBarItem,
  });

  final Widget body;
  final AppRoutes? selectedSideBarItem;

  // search input size
  static const double _searchInputHeight = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: SizedBox(
          height: _searchInputHeight,
          child: TextField(
            readOnly: true,
            onTap: () {
              AppRouter.redirectTo(
                context: context,
                route: AppRoutes.search,
              );
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                left: 15.0,
                top: 10.0,
                bottom: 10.0,
              ),
              hintText: "Search",
              suffixIcon: const Icon(
                Icons.search,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_searchInputHeight / 2),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),
          )
        ],
      ),
      drawer: SideBar(
        selectedItem: selectedSideBarItem,
      ),
      body: body,
    );
  }
}
