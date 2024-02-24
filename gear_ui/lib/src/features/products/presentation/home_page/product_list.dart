import 'package:flutter/material.dart';

// internal packages
import 'package:gear_ui/src/features/products/data/product_repository.dart';
import 'package:gear_ui/src/features/products/domain/product.dart';
import 'package:gear_ui/src/features/products/presentation/home_page/product_card.dart';

class HomePageProductList extends StatefulWidget {
  const HomePageProductList({
    super.key,
    this.products = const <Product>[],
  });

  final List<Product> products;

  @override
  State<HomePageProductList> createState() => _HomePageProductListState();
}

class _HomePageProductListState extends State<HomePageProductList> {
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: _products == null
          // TODO: make skeleton loading.
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
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
    );
  }
}
