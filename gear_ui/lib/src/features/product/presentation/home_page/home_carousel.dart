import 'package:flutter/material.dart';

// external packages
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gear_ui/src/features/product/domain/home_product.dart';
import 'package:gear_ui/src/utils/assets_path.dart';
import 'package:gear_ui/src/widgets/image_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePageCarousel extends StatefulWidget {
  HomePageCarousel({
    super.key,
    this.banners = const [],
    // this.products = const [],
  });

  final List<String> banners;

  final List<HomeProduct> products = [
    HomeProduct(
      id: 1,
      name: "Pr 01",
      price: 10,
    ),
    HomeProduct(
      id: 1,
      name: "Pr 02",
      price: 10,
    ),
    HomeProduct(
      id: 1,
      name: "Pr 03",
      price: 10,
    ),
    HomeProduct(
      id: 1,
      name: "Pr 04",
      price: 10,
    ),
    HomeProduct(
      id: 1,
      name: "Pr 05",
      price: 10,
    ),
  ];

  static const int itemCount = 5;

  @override
  State<HomePageCarousel> createState() => _HomePageCarouselState();
}

class _HomePageCarouselState extends State<HomePageCarousel> {
  int _activePage = 0;
  final CarouselController _controller = CarouselController();

  final Curve _changePageAnimation = Curves.easeInOut;

  // page config
  static const double _spacing = 0;

  // indicator config
  static const double _dotSize = 16;
  static const double _indicatorPadding = 15;

  void _handleIndicatorClick(int index) {
    _controller.animateToPage(index);
  }

  void _handleChangeActivePage(int index, CarouselPageChangedReason reason) {
    setState(() {
      _activePage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    final Widget indicator = Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(_indicatorPadding),
      child: AnimatedSmoothIndicator(
        activeIndex: _activePage,
        count: widget.products.length,
        curve: _changePageAnimation,
        onDotClicked: _handleIndicatorClick,
        effect: ExpandingDotsEffect(
          dotWidth: _dotSize,
          dotHeight: _dotSize,
          activeDotColor: theme.primaryColor,
          dotColor: theme.indicatorColor,
        ),
      ),
    );

    return Column(
      children: <Widget>[
        CarouselSlider.builder(
          carouselController: _controller,
          options: CarouselOptions(
            autoPlayCurve: _changePageAnimation,
            initialPage: _activePage,
            onPageChanged: _handleChangeActivePage,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1,
          ),
          itemCount: widget.products.length,
          itemBuilder: (context, index, realIndex) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: _spacing,
              ),
              child: _cardBuilder(
                theme,
                mediaQuery,
                widget.products[index],
              ),
            );
          },
        ),
        indicator,
      ],
    );
  }

  Widget _cardBuilder(
    ThemeData theme,
    MediaQueryData mediaQuery,
    HomeProduct product,
  ) {
    return GestureDetector(
      child: SizedBox(
        width: mediaQuery.size.width,
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: ImageWidget(
            imageUrl: null,
            width: double.infinity,
            height: double.infinity,
            fallbackImage: Image.asset(
              AssetsPath.fallbackImage(
                "no_image.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
