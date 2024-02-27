import 'package:flutter/material.dart';

// internal packages
import 'package:gear_ui/src/features/product/domain/home_product.dart';
import 'package:gear_ui/src/features/product/presentation/home_page/home_product_card.dart';

class HomeProductList extends StatefulWidget {
  const HomeProductList({
    super.key,
    this.products = const <HomeProduct>[],
  });

  final List<HomeProduct> products;

  @override
  State<HomeProductList> createState() => _HomeProductListState();
}

class _HomeProductListState extends State<HomeProductList> {
  static const int _maxItemPerRow = 2;
  static const double _contentSectionPadding = 5;

  List<HomeProduct> get _products => widget.products;

  List<List<HomeProduct>> _transformData(List<HomeProduct> products) {
    int length = products.length;
    final List<List<HomeProduct>> result = [];
    List<HomeProduct> productsPerRow = [];

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
  void dispose() {
    _products.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _contentSectionPadding,
      ),
      child: Column(
        children: <Widget>[
          ..._transformData(_products).map((productsPerRow) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
          }),
        ],
      ),
    );
  }
}
