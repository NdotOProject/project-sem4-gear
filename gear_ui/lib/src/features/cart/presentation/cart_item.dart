import 'package:flutter/material.dart';

// internal packages
import 'package:gear_ui/src/features/cart/domain/cart_product.dart';
import 'package:gear_ui/src/routes/app_routes.dart';
import 'package:gear_ui/src/utils/assets_path.dart';
import 'package:gear_ui/src/widgets/image_widget.dart';
import 'package:gear_ui/src/widgets/quantity_control_widget.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    super.key,
    required this.product,
  });

  final CartProduct product;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  static const double _gapBetweenLeftAndRight = 10;

  static const double _contentSectionPadding = 10;
  static const double _contentSectionHeight = 150;

  static const double _imageBorderRadius = 8;

  int _quantity = 0;

  CartProduct get _product => widget.product;

  int get _smallestQuantity {
    return 1;
  }

  int get _biggestQuantity {
    return 100;
  }

  void _handleClickToCard() {
    AppRoutes.productDetail.asDestination(
      context: context,
      productId: _product.id,
    );
  }

  @override
  void initState() {
    super.initState();

    _quantity = _product.quantity;
  }

  @override
  Widget build(BuildContext context) {
    final Image fallbackImage = Image.asset(
      AssetsPath.fallbackImage(
        "no_image.png",
      ),
      fit: BoxFit.cover,
    );

    final Widget productTitle = Container(
      width: double.infinity,
      alignment: Alignment.topCenter,
      child: Text(
        _product.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    final Widget productInfo = Text(
      "Size: ${_product.size}",
    );

    final Widget priceAndQuantityControl = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "${_product.price}",
          ),
        ),
        Expanded(
          child: QuantityControlWidget(
            initial: _quantity,
            minimum: _smallestQuantity,
            maximum: _biggestQuantity,
          ),
        ),
      ],
    );

    return GestureDetector(
      onTap: _handleClickToCard,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(_contentSectionPadding),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_imageBorderRadius),
                  ),
                  child: ImageWidget(
                    height: _contentSectionHeight,
                    width: double.infinity,
                    imageUrl: _product.avatar,
                    fallbackImage: fallbackImage,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.only(left: _gapBetweenLeftAndRight),
                  height: _contentSectionHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: productTitle,
                      ),
                      Expanded(
                        child: productInfo,
                      ),
                      Expanded(
                        child: priceAndQuantityControl,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
