import 'package:flutter/material.dart';

// internal packages
import 'package:gear_ui/src/utils/assets_path.dart';
import 'package:gear_ui/src/widgets/carousel_widget.dart';
import 'package:gear_ui/src/widgets/image_widget.dart';

class HomePageCarousel extends StatefulWidget {
  const HomePageCarousel({
    super.key,
    required this.imageUrls,
  });

  final List<String> imageUrls;

  @override
  State<HomePageCarousel> createState() => _HomePageCarouselState();
}

class _HomePageCarouselState extends State<HomePageCarousel> {
  final Curve _changePageAnimation = Curves.easeInOut;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    final Image fallbackImage = Image.asset(
      AssetsPath.fallbackImage(
        "no_image.png",
      ),
      fit: BoxFit.cover,
    );

    return CarouselWidget<String>(
      curve: _changePageAnimation,
      items: widget.imageUrls,
      itemBuilder: (context, item) {
        return SizedBox(
          width: mediaQuery.size.width,
          child: ImageWidget(
            imageUrl: null, //item,
            width: double.infinity,
            height: double.infinity,
            fallbackImage: fallbackImage,
          ),
        );
      },
      viewportFraction: 1,
      autoPlayOptions: const AutoPlayOptions(),
      indicator: CarouselIndicator(
        type: IndicatorTypes.expandingDot,
        size: 16,
        itemsGap: 5,
        borderRadius: BorderRadius.circular(8),
        borderWidth: 2,
        margin: const EdgeInsets.symmetric(
          vertical: 20,
        ),
      ),
    );
  }
}
