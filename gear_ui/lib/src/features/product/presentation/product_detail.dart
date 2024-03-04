import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// internal packages
import 'package:gear_ui/src/exceptions/not_found_page.dart';
import 'package:gear_ui/src/features/product/data/product_repository.dart';
import 'package:gear_ui/src/features/product/domain/detail_product.dart';
import 'package:gear_ui/src/layouts/children_page_layout.dart';
import 'package:gear_ui/src/utils/assets_path.dart';
import 'package:gear_ui/src/widgets/carousel_widget.dart';
import 'package:gear_ui/src/widgets/image_widget.dart';

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
  final _productRepository = ProductRepository.instance;
  DetailProduct? _product;

  @override
  void initState() {
    super.initState();
    _productRepository
        .then((repository) {
          return repository.findById(widget.productId!);
        })
        .then(DetailProduct.fromCached)
        .then((detailProduct) {
          setState(() {
            _product = detailProduct;
          });
        })
        .catchError((err) {
          if (kDebugMode) {
            print(err);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    final List<String> images = _product?.images ??
        [
          "no_image.png",
          "no_image.png",
          "no_image.png",
        ];

    final Image fallbackImage = Image.asset(
      AssetsPath.fallbackImage(
        "no_image.png",
      ),
      fit: BoxFit.cover,
    );

    final Widget imageSlider = CarouselWidget(
      items: images,
      itemBuilder: (context, imageUrl) {
        return ImageWidget(
          width: mediaQuery.size.width,
          imageUrl: imageUrl,
          fallbackImage: fallbackImage,
        );
      },
      viewportFraction: 1,
      indicator: CarouselIndicator(
        type: IndicatorTypes.reflectsContent,
        size: 50,
        borderWidth: 2,
        innerIndicator: true,
        position: const IndicatorPosition(
          bottom: 0,
        ),
        margin: const EdgeInsets.only(
          left: 5,
        ),
        itemsGap: 5,
        color: theme.colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(10),
      ),
    );
    // Expanded(
    //   child: Stack(
    //     children: [
    //       CarouselSlider.builder(
    //         itemCount: images.length,
    //         itemBuilder: (context, index, realIndex) {

    //         },
    //         options: CarouselOptions(
    //           height: double.infinity,
    //           viewportFraction: 1,
    //         ),
    //       ),
    //       Positioned(
    //         bottom: 20,
    //         left: 0,
    //         right: 0,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: <Widget>[
    //             ...images.map((imageUrl) {
    //               return InkWell(
    //                 onTap: () {},
    //                 child: Container(
    //                   width: 50,
    //                   height: 50,
    //                   padding: const EdgeInsets.all(2),
    //                   margin: const EdgeInsets.symmetric(
    //                     horizontal: 5,
    //                   ),
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(10),
    //                     color: theme.primaryColor,
    //                   ),
    //                   child: Container(
    //                     clipBehavior: Clip.hardEdge,
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(8),
    //                     ),
    //                     child: ImageWidget(
    //                       width: mediaQuery.size.width,
    //                       imageUrl: imageUrl,
    //                       fallbackImage: Image.asset(
    //                         AssetsPath.fallbackImage(
    //                           "no_image.png",
    //                         ),
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               );
    //             }),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    return _product == null
        ? NotFoundPage(
            childrenPage: true,
            message: "Product with id: ${widget.productId} does not exists!",
          )
        : ChildrenPageLayout(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  imageSlider,
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _product!.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: theme.textTheme.titleLarge?.fontSize,
                            ),
                          ),
                          Text(
                            "${_product!.price}",
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          )
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
