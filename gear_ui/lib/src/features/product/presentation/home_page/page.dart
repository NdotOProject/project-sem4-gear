import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// internal packages
import 'package:gear_ui/src/features/product/data/product_repository.dart';
import 'package:gear_ui/src/features/product/domain/home_product.dart';
import 'package:gear_ui/src/features/product/presentation/home_page/home_carousel.dart';
import 'package:gear_ui/src/features/product/presentation/home_page/home_product_list.dart';
import 'package:gear_ui/src/layouts/main_page_layout.dart';
import 'package:gear_ui/src/routes/app_routes.dart';
import 'package:gear_ui/src/utils/pagination_param.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Radius _carouselContainerRadius = Radius.elliptical(30, 20);
  static const double _gapBetweenCarouselAndList = 20;

  static const int _pageSize = 4;

  Future<ProductRepository> get _productRepository {
    return ProductRepository.instance;
  }

  final ScrollController _scrollController = ScrollController();

  final List<HomeProduct> _products = [];
  int _pageNumber = 1;
  bool _hasMore = true;
  bool _loading = false;

  Future<void> _handleRefreshData() async {
    setState(() {
      _pageNumber = 1;
      _hasMore = true;
      _loading = false;
      _products.clear();
    });

    _fetchData();
  }

  Future<void> _fetchData() async {
    if (_loading) {
      return;
    }
    _loading = true;

    _productRepository
        .then((repository) {
          return repository.findAll(
            param: PaginationParam(
              page: _pageNumber,
              size: _pageSize,
            ),
          );
        })
        .then(HomeProduct.fromIterableCachedProducts)
        .then((homeProducts) {
          if (mounted) {
            setState(() {
              _loading = false;

              _pageNumber++;

              if (homeProducts.length < _pageSize) {
                _hasMore = false;
              }

              _products.addAll(homeProducts);
            });
          }
        })
        .catchError((err, stackTrace) {
          if (kDebugMode) {
            print(err);
          }
        });
  }

  @override
  void initState() {
    super.initState();

    _fetchData();

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        _fetchData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

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
      child: const HomePageCarousel(
        imageUrls: <String>[
          "no_image.png",
          "no_image.png",
          "no_image.png",
          "no_image.png",
          "no_image.png",
        ],
      ),
    );

    Widget productList = HomeProductList(
      products: _products,
    );

    return MainPageLayout(
      selectedSideBarItem: AppRoutes.home,
      body: RefreshIndicator.adaptive(
        onRefresh: _handleRefreshData,
        child: ListView(
          controller: _scrollController,
          children: <Widget>[
            carouselSection,
            const SizedBox(
              height: _gapBetweenCarouselAndList,
            ),
            productList,
            if (_hasMore)
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 30,
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
