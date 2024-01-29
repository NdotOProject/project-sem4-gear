import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gear_ui/src/common/widgets/image_widget.dart';
import 'package:gear_ui/src/features/products/data/product_repository.dart';
import 'package:gear_ui/src/features/products/domain/product.dart';
import 'package:gear_ui/src/layouts/main_page_layout.dart';
import 'package:gear_ui/src/routes/app_route.dart';
import 'package:gear_ui/src/utils/assets_paths.dart';

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
    return MainPageLayout(
      selectedSideBarItem: AppRoutes.home,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          scrollDirection: Axis.vertical,
          children: _products.map((product) {
            return InkWell(
              onTap: () {
                context.goNamed(
                  AppRoutes.productDetail.name,
                  pathParameters: {
                    "id": "${product.id}",
                  },
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageWidget(
                    imageUrl: null,
                    fallbackImage: Image.asset(
                      Assets.fallbackImage("no_image.png"),
                      fit: BoxFit.cover,
                    ),
                    height: 100,
                    width: 100,
                  ),
                  Column(
                    children: [
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${product.price}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
