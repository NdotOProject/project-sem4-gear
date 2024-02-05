import 'package:flutter/material.dart';
import 'package:gear_ui/src/exceptions/not_found_page.dart';
import 'package:gear_ui/src/features/products/data/product_repository.dart';
import 'package:gear_ui/src/features/products/domain/product.dart';
import 'package:gear_ui/src/layouts/children_page_layout.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({
    super.key,
    required this.productId,
  });

  final int? productId;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  static const _productRepository = ProductRepository();
  Product? _product;

  @override
  void initState() {
    _productRepository.findById(widget.productId!).then((product) {
      setState(() {
        _product = product;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _product == null
        ? NotFoundPage(
            childrenPage: true,
            message: "Product with id: ${widget.productId} does not exists!",
          )
        : ChildrenPageLayout(
            title: Text(
              _product!.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Text("${widget.productId}"),
                ],
              ),
            ),
          );
  }
}
