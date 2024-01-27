import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.imageUrl,
    required this.fallbackImage,
    this.height = 50,
    this.width = 50,
  });

  final String imageUrl;
  final Image fallbackImage;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => SizedBox(
        width: width < 50 ? width : 50,
        height: height < 50 ? height : 50,
        child: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
      errorWidget: (context, url, error) => fallbackImage,
    );
  }
}
