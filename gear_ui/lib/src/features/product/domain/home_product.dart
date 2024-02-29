import 'package:gear_ui/src/local_storage/objects/cached_product.dart';

class HomeProduct {
  int id;
  String name;
  String? description;
  double price;
  String? avatar;

  HomeProduct({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.avatar,
  });

  factory HomeProduct.fromCachedProduct(CachedProduct cachedProduct) {
    return HomeProduct(
      id: cachedProduct.id,
      name: cachedProduct.name,
      description: cachedProduct.description,
      price: cachedProduct.price,
      avatar: cachedProduct.avatarImageUrl,
    );
  }

  static List<HomeProduct> fromIterableCachedProducts(
      Iterable<CachedProduct> iterable) {
    return [...iterable.map(HomeProduct.fromCachedProduct)];
  }
}
