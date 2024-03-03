import 'package:flutter/material.dart';
import 'package:gear_ui/src/features/cart/data/cart_repository.dart';
import 'package:gear_ui/src/features/cart/presentation/page_controller.dart';

// internal packages
import 'package:gear_ui/src/features/product/domain/home_product.dart';
import 'package:gear_ui/src/local_storage/objects/cached_cart_item.dart';
import 'package:gear_ui/src/routes/app_routes.dart';
import 'package:gear_ui/src/utils/assets_path.dart';
import 'package:gear_ui/src/widgets/image_widget.dart';
import 'package:get/get.dart';

class HomeProductCard extends StatefulWidget {
  const HomeProductCard({
    super.key,
    required this.product,
    this.favorite = false,
  });

  final HomeProduct product;
  final bool favorite;

  @override
  State<HomeProductCard> createState() => _HomeProductCardState();
}

class _HomeProductCardState extends State<HomeProductCard> {
  static const double _cardHeight = 300.0;
  static const double _cardWidth = double.infinity;
  static const double _infoSectionHeight = 130.0;
  static const double _infoSectionPadding = 8.0;

  final CartPageController _cartController = Get.find();

  Future<CartRepository> get _cartRepository {
    return CartRepository.instance();
  }

  late bool _favorite;

  void _handleTapToFavoriteButton() {
    setState(() {
      _favorite = !_favorite;
    });
  }

  void _handleTapToCard(BuildContext context) {
    AppRoutes.productDetail.asDestination(
      context: context,
      productId: widget.product.id,
    );
  }

  void _handleAddToCart() {
    _cartController.addItem(widget.product.id).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Added to cart",
          ),
          action: SnackBarAction(
            label: 'See',
            onPressed: () {
              AppRoutes.cart.asDestination(
                context: context,
              );
            },
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();

    _favorite = widget.favorite;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Image fallbackImage = Image.asset(
      AssetsPath.fallbackImage(
        "no_image.png",
      ),
      fit: BoxFit.cover,
    );

    final Widget productImage = Positioned.fill(
      bottom: _infoSectionHeight,
      child: ImageWidget(
        imageUrl: widget.product.avatar,
        fallbackImage: fallbackImage,
        width: _cardWidth,
        height: _cardHeight - _infoSectionHeight,
      ),
    );

    final Widget topItems = Align(
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(
          //   child: Banner(
          //     message: "-50%",
          //     location: BannerLocation.topStart,
          //     textStyle: TextStyle(
          //       fontSize: theme.textTheme.labelMedium?.fontSize,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          IconButton(
            onPressed: _handleTapToFavoriteButton,
            icon: Icon(
              _favorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );

    final Widget infoSection = Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: _cardWidth,
        height: _infoSectionHeight,
        child: Padding(
          padding: const EdgeInsets.all(
            _infoSectionPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Text(
                      widget.product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: theme.textTheme.titleMedium?.fontSize,
                      ),
                    ),
                    Text(
                      widget.product.description ?? "",
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: theme.textTheme.bodySmall?.fontSize,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.product.price}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox.square(
                      dimension: 30,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: const CircleBorder(),
                        ),
                        onPressed: _handleAddToCart,
                        child: const Icon(
                          Icons.add,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return InkWell(
      onTap: () {
        _handleTapToCard(context);
      },
      child: SizedBox(
        height: _cardHeight,
        width: _cardWidth,
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: <Widget>[
              productImage,
              topItems,
              infoSection,
            ],
          ),
        ),
      ),
    );
  }
}
