import 'package:flutter/material.dart';

// internal packages
import 'package:gear_ui/src/features/cart/domain/cart_product.dart';
import 'package:gear_ui/src/features/product/data/product_repository.dart';
import 'package:gear_ui/src/features/product_size/data/product_size_repository.dart';
import 'package:gear_ui/src/local_storage/objects/cached_cart_item.dart';
import 'package:gear_ui/src/local_storage/objects/cached_product_size.dart';
import 'package:gear_ui/src/routes/app_routes.dart';
import 'package:gear_ui/src/utils/assets_path.dart';
import 'package:gear_ui/src/widgets/image_widget.dart';
import 'package:gear_ui/src/widgets/quantity_control_widget.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    super.key,
    required this.item,
    required this.onSelected,
  });

  final CachedCartItem item;
  final ValueChanged<CachedCartItem> onSelected;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  static const double _cardHeight = 350;
  static const double _contentSectionIndent = 10;

  int _quantity = 0;
  CartProduct? _product;
  List<CachedProductSize> _productSizes = [];

  Future<ProductRepository> get _productRepository {
    return ProductRepository.instance;
  }

  Future<ProductSizeRepository> get _productSizeRepository {
    return ProductSizeRepository.instance;
  }

  CachedCartItem get _item => widget.item;

  int get _smallestQuantity => 1;

  int get _biggestQuantity => _product!.quantity;

  void _handleTapToCard() {
    AppRoutes.productDetail.asDestination(
      context: context,
      productId: _product!.id,
    );
  }

  @override
  void initState() {
    super.initState();

    _productRepository.then((repository) {
      return repository.findById(_item.productId);
    }).then((cachedProduct) {
      setState(() {
        _product = cachedProduct != null
            ? CartProduct.fromCachedProduct(cachedProduct)
            : CartProduct(
                id: 0,
                name: '',
                price: 0,
                quantity: 0,
              );

        _productSizeRepository.then((repository) {
          return repository.findAllByProductId(_product?.id ?? 0);
        }).then((sizes) {
          setState(() {
            _productSizes = sizes;
          });
        });
      });
    });

    _quantity = _item.quantity;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    if (_product == null) {
      return const Card(
        child: SizedBox(
          height: _cardHeight,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    final Image fallbackImage = Image.asset(
      AssetsPath.fallbackImage(
        "no_image.png",
      ),
      fit: BoxFit.cover,
    );

    final Widget productTitle = Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        _product!.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    final Widget productInfo = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: DropdownMenu(
              inputDecorationTheme: const InputDecorationTheme(
                border: UnderlineInputBorder(),
              ),
              label: const Text("Size"),
              initialSelection:
                  _productSizes.isNotEmpty ? _productSizes[0] : null,
              menuStyle: const MenuStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.zero),
              ),
              dropdownMenuEntries: [
                ..._productSizes.map((productSize) {
                  return DropdownMenuEntry(
                    value: productSize,
                    label: productSize.name,
                  );
                }),
              ],
            ),
          ),
          const Expanded(
            child: Text(
              "Color: blue",
            ),
          ),
        ],
      ),
    );

    final Widget priceAndQuantityControl = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            "\$${_product!.price}",
            style: TextStyle(
              fontSize: theme.textTheme.labelLarge?.fontSize ?? 16,
            ),
          ),
        ),
        Expanded(
          child: QuantityControlWidget(
            initial: _quantity <= (_product?.quantity ?? 0)
                ? _quantity
                : (_product?.quantity ?? 0),
            minimum: _smallestQuantity,
            maximum: _biggestQuantity,
            onChanged: (value) {
              setState(() {
                _item.quantity = value;
                _item.save();
              });
            },
          ),
        ),
      ],
    );

    return GestureDetector(
      onTap: _handleTapToCard,
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: theme.primaryColor,
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: _cardHeight,
              child: Card(
                clipBehavior: Clip.hardEdge,
                color: theme.colorScheme.onPrimary,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: ImageWidget(
                          height: double.infinity,
                          width: double.infinity,
                          imageUrl: _product?.avatar,
                          fallbackImage: fallbackImage,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: _contentSectionIndent,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: productTitle,
                            ),
                            Expanded(
                              flex: 3,
                              child: productInfo,
                            ),
                            Expanded(
                              flex: 3,
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
            Positioned(
              left: 0,
              top: 0,
              child: Transform.scale(
                scale: 1.2,
                child: Checkbox.adaptive(
                  onChanged: (checked) {
                    setState(() {
                      _item.selected = !_item.selected;
                      _item.save();
                      widget.onSelected(_item);
                    });
                  },
                  value: _item.selected,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
