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

  factory HomeProduct.fromCached(CachedProduct cached) {
    return HomeProduct(
      id: cached.id,
      name: cached.name,
      description: cached.description,
      price: cached.price,
      avatar: cached.avatarImageUrl,
    );
  }

  static List<HomeProduct> fromCachedIterable(
      Iterable<CachedProduct> iterable) {
    return [...iterable.map(HomeProduct.fromCached)];
  }
}
