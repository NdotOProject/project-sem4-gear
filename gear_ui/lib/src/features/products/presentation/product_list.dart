import 'package:flutter/material.dart';
import 'package:gear_ui/src/features/products/data/product_repository.dart';
import 'package:gear_ui/src/features/products/domain/product.dart';
import 'package:gear_ui/src/features/products/presentation/product_list_card.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  static const _productRepository = ProductRepository();
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();

    _productRepository.findAll().then((value) {
      setState(() {
        _products = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        children: [
          ..._products.map((product) {
            return ProductListCard(product: product);
          })
        ],
      ),
    );
  }
}
