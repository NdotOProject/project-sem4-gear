import 'package:flutter/material.dart';
import 'package:gear_ui/src/common/widgets/image_widget.dart';
import 'package:gear_ui/src/features/products/domain/product.dart';
import 'package:gear_ui/src/utils/assets_paths.dart';

class ProductListCard extends StatelessWidget {
  const ProductListCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageWidget(
          imageUrl: '',
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
    );
  }
}
