import 'package:flutter/material.dart';
import 'package:gear_ui/src/features/products/domain/product.dart';
import 'package:gear_ui/src/layouts/children_page_layout.dart';
import 'package:gear_ui/src/utils/assets_path.dart';
import 'package:gear_ui/src/widgets/image_widget.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final List<Product> products = [
    Product(
      categoryId: 1,
      brandId: 1,
      code: "ja",
      name: "P1",
      price: 100029,
    ),
    Product(
      categoryId: 1,
      brandId: 1,
      code: "ja",
      name: "P2",
      price: 100029,
    ),
    Product(
      categoryId: 1,
      brandId: 1,
      code: "ja",
      name: "P3",
      price: 100029,
    ),
    Product(
      categoryId: 1,
      brandId: 1,
      code: "ja",
      name: "P4",
      price: 100029,
    ),
    Product(
      categoryId: 1,
      brandId: 1,
      code: "ja",
      name: "P5",
      price: 100029,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ChildrenPageLayout(
      body: ListView.separated(
        itemCount: products.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            indent: 10,
            endIndent: 10,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return _ProductCard(
            product: products[index],
          );
        },
      ),
    );
  }
}

class _ProductCard extends StatefulWidget {
  const _ProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        child: Row(
          children: [
            Expanded(
              child: ImageWidget(
                height: 150,
                imageUrl: null,
                fallbackImage: Image.asset(
                  AssetsPath.fallbackImage(
                    "no_image.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${widget.product.price}"),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.remove,
                              ),
                            ),
                            Text("1"),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
