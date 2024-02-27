import 'package:flutter/material.dart';

// internal packages
import 'package:gear_ui/src/features/product/presentation/home_page/home_carousel.dart';
import 'package:gear_ui/src/features/product/presentation/home_page/home_product_list.dart';
import 'package:gear_ui/src/layouts/main_page_layout.dart';
import 'package:gear_ui/src/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const Radius _carouselContainerRadius = Radius.elliptical(30, 20);
  static const double _gapBetweenCarouselAndList = 20;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Widget carouselSection = Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.inversePrimary,
        borderRadius: const BorderRadius.only(
          bottomLeft: _carouselContainerRadius,
          bottomRight: _carouselContainerRadius,
        ),
      ),
      child: HomePageCarousel(),
    );

    const Widget productList = HomeProductList();

    return MainPageLayout(
      selectedSideBarItem: AppRoutes.home,
      body: RefreshIndicator.adaptive(
        onRefresh: () async {},
        child: ListView(
          children: <Widget>[
            carouselSection,
            const SizedBox(
              height: _gapBetweenCarouselAndList,
            ),
            productList,
          ],
        ),
      ),
    );
  }
}
