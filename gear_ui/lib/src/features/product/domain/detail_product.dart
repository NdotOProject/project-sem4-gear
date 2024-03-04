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

  static DetailProduct? fromCached(CachedProduct? cached) {
    if (cached != null) {
      return DetailProduct(
        name: cached.name,
        price: cached.price,
      );
    }
    return null;
  }
}
