import 'package:flutter/material.dart';

// internal packages
import 'package:gear_ui/src/features/cart/domain/cart_product.dart';
import 'package:gear_ui/src/features/product/data/product_repository.dart';
import 'package:gear_ui/src/features/product_color/data/product_color_repository.dart';
import 'package:gear_ui/src/features/product_size/data/product_size_repository.dart';
import 'package:gear_ui/src/local_storage/objects/cached_cart_item.dart';
import 'package:gear_ui/src/local_storage/objects/cached_product_color.dart';
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
  // config height of card elements.
  static const double _imageContainerHeight = 200;
  static const double _titleContainerHeight = 30;
  static const double _dropdownOptionsContainerHeight = 70;
  static const double _priceAndQuantityControlContainerHeight = 80;

  // other config of card
  static const double _cardHeight = _imageContainerHeight +
      _titleContainerHeight +
      _dropdownOptionsContainerHeight +
      _priceAndQuantityControlContainerHeight +
      8; // because overflowed 8.0 pixels
  static const double _gapBetweenElementsInAnRow = 2;
  static const double _contentSectionIndent = 10;

  final _errorProduct = CartProduct(id: 0, name: '', price: 0, quantity: 0);
  final _errorSize = CachedProductSize(id: 0, name: "", productIds: []);
  final _errorColor = CachedProductColor(id: 0, name: "", productIds: []);

  CachedCartItem get _item => widget.item;

  CartProduct? _product;
  List<CachedProductSize> _productSizes = [];
  List<CachedProductColor> _productColors = [];
  CachedProductSize? _selectedSize;
  CachedProductColor? _selectedColor;

  int get _biggestQuantity => _product?.quantity ?? 0;

  int get _smallestQuantity => _biggestQuantity > 0 ? 1 : 0;

  int get _quantity =>
      _item.quantity <= _biggestQuantity ? _item.quantity : _biggestQuantity;

  void _handleTapToCard() {
    AppRoutes.productDetail.asDestination(
      context: context,
      productId: _product!.id,
    );
  }

  void _handleSelectItem(bool? _) {
    setState(() {
      _item.selected = !_item.selected;
      _item.save();
      widget.onSelected(_item);
    });
  }

  void _handleSelectSize(CachedProductSize? size) {
    setState(() {
      _selectedSize = size;
      _item.sizeId = _selectedSize?.id;
      _item.save();
    });
  }

  void _handleSelectColor(CachedProductColor? color) {
    setState(() {
      _selectedColor = color;
      _item.colorId = _selectedColor?.id;
      _item.save();
    });
  }

  void _handleChangeQuantity(int value) {
    setState(() {
      _item.quantity = value;
      _item.save();
    });
  }

  void _loadRequireData() async {
    // get repositories.
    final productRepository = await ProductRepository.instance;
    final sizeRepository = await ProductSizeRepository.instance;
    final colorRepository = await ProductColorRepository.instance;

    // init require data.
    final cachedProduct = await productRepository.findById(_item.productId);
    List<CachedProductSize> cachedSizes = [];
    List<CachedProductColor> cachedColors = [];
    CachedProductSize? selectedSize;
    CachedProductColor? selectedColor;

    // load data.
    if (cachedProduct != null) {
      cachedSizes = await sizeRepository.findAllByProductId(cachedProduct.id);
      cachedColors = await colorRepository.findAllByProductId(cachedProduct.id);
    }

    if (_item.sizeId != null) {
      selectedSize = await sizeRepository.findById(_item.sizeId!) ?? _errorSize;
    } else if (cachedSizes.isNotEmpty) {
      selectedSize = _productSizes[0];
    }

    if (_item.colorId != null) {
      selectedColor =
          await colorRepository.findById(_item.colorId!) ?? _errorColor;
    } else if (cachedColors.isNotEmpty) {
      selectedColor = cachedColors[0];
    }

    // set data
    setState(() {
      _product = cachedProduct != null
          ? CartProduct.fromCached(cachedProduct)
          : _errorProduct;

      _productColors = cachedColors;
      _productSizes = cachedSizes;

      _handleSelectColor(selectedColor);
      _handleSelectSize(selectedSize);
    });
  }

  @override
  void initState() {
    super.initState();

    _loadRequireData();
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

    final Widget productAvatarImage = ImageWidget(
      height: _imageContainerHeight,
      width: double.infinity,
      imageUrl: _product?.avatar,
      fallbackImage: Image.asset(
        AssetsPath.fallbackImage(
          "no_image.png",
        ),
        fit: BoxFit.cover,
      ),
    );

    final Widget productTitle = SizedBox(
      height: _titleContainerHeight,
      width: double.infinity,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          _product!.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: theme.textTheme.titleMedium?.fontSize ?? 24,
          ),
        ),
      ),
    );

    final Widget dropdownOptions = SizedBox(
      height: _dropdownOptionsContainerHeight,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          // size options
          Expanded(
            child: DropdownMenu<CachedProductSize>(
              onSelected: _handleSelectSize,
              expandedInsets: const EdgeInsets.symmetric(
                horizontal: _gapBetweenElementsInAnRow,
              ),
              inputDecorationTheme: const InputDecorationTheme(
                border: UnderlineInputBorder(),
                contentPadding: EdgeInsets.zero,
              ),
              label: const Text("Size"),
              initialSelection: _selectedSize,
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
          // color options
          Expanded(
            child: DropdownMenu<CachedProductColor>(
              onSelected: _handleSelectColor,
              expandedInsets: const EdgeInsets.symmetric(
                horizontal: _gapBetweenElementsInAnRow,
              ),
              inputDecorationTheme: const InputDecorationTheme(
                border: UnderlineInputBorder(),
                contentPadding: EdgeInsets.zero,
              ),
              label: const Text("Color"),
              initialSelection: _selectedColor,
              menuStyle: const MenuStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.zero),
              ),
              dropdownMenuEntries: [
                ..._productColors.map((productColor) {
                  return DropdownMenuEntry(
                    value: productColor,
                    label: productColor.name,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );

    final Widget priceAndQuantityControl = SizedBox(
      width: double.infinity,
      height: _priceAndQuantityControlContainerHeight,
      child: Row(
        children: <Widget>[
          // price
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: _gapBetweenElementsInAnRow,
              ),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: "Price",
                  prefix: Text("\$"),
                  contentPadding: EdgeInsets.zero,
                ),
                readOnly: true,
                controller: TextEditingController(text: "${_product!.price}"),
                style: TextStyle(
                  fontSize: theme.textTheme.labelLarge?.fontSize ?? 16,
                ),
              ),
            ),
          ),
          // quantity control
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: _gapBetweenElementsInAnRow,
              ),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Quantity",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                child: QuantityControlWidget(
                  inputDecoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                  ),
                  initial: _quantity,
                  minimum: _smallestQuantity,
                  maximum: _biggestQuantity,
                  onChanged: _handleChangeQuantity,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: _handleTapToCard,
      child: Card(
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
                    productAvatarImage,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: _contentSectionIndent,
                      ),
                      child: Column(
                        children: <Widget>[
                          productTitle,
                          dropdownOptions,
                          priceAndQuantityControl,
                        ],
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
                  onChanged: _handleSelectItem,
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
