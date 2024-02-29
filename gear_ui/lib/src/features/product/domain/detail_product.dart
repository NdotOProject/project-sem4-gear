import 'package:gear_ui/src/local_storage/objects/cached_product.dart';

class DetailProduct {
  String name;
  double price;
  List<String>? images;

  DetailProduct({
    required this.name,
    required this.price,
    this.images,
  });

  static DetailProduct? fromCachedProduct(CachedProduct? cachedProduct) {
    if (cachedProduct != null) {
      return DetailProduct(
        name: cachedProduct.name,
        price: cachedProduct.price,
      );
    }
    return null;
  }
}
