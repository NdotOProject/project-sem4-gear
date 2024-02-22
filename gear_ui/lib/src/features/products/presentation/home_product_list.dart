import 'package:flutter/material.dart';

// internal packages
import 'package:gear_ui/src/features/products/data/product_repository.dart';
import 'package:gear_ui/src/features/products/domain/product.dart';
import 'package:gear_ui/src/features/products/presentation/home_product_card.dart';
import 'package:gear_ui/src/layouts/main_page_layout.dart';
import 'package:gear_ui/src/routes/app_routes.dart';

class HomeProductList extends StatefulWidget {
  const HomeProductList({super.key});

  @override
  State<HomeProductList> createState() => _HomeProductListState();
}

class _HomeProductListState extends State<HomeProductList> {
  static const int _maxItemPerRow = 2;

  static const ProductRepository _productRepository = ProductRepository();

  List<Product>? _products;

  void _fetchData() {
    _productRepository.findAll().then((products) {
      if (mounted) {
        setState(() {
          _products = products;
        });
      }
    });
  }

  List<List<Product>> _transformData(List<Product> products) {
    int length = products.length;
    final List<List<Product>> result = [];
    List<Product> productsPerRow = [];

    for (var product in products) {
      productsPerRow.add(product);
      length--;
      if (productsPerRow.length == _maxItemPerRow) {
        result.add(productsPerRow);
        productsPerRow = [];
      } else if (length == 0) {
        result.add(productsPerRow);
      }
    }

    return result;
  }

  @override
  void initState() {
    super.initState();

    _fetchData();
  }

  @override
  void dispose() {
    _products = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainPageLayout(
      selectedSideBarItem: AppRoutes.home,
      body: RefreshIndicator(
        onRefresh: () async {
          _fetchData();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          child: _products == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    ..._transformData(_products ?? []).map((productsPerRow) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...productsPerRow.map((product) {
                            return Expanded(
                              flex: 1,
                              child: HomeProductCard(
                                product: product,
                              ),
                            );
                          }),
                          if (productsPerRow.length < _maxItemPerRow)
                            Expanded(
                              flex: _maxItemPerRow - productsPerRow.length,
                              child: Container(),
                            ),
                        ],
                      );
                    })
                  ],
                ),
        ),
      ),
    );
  }
}
