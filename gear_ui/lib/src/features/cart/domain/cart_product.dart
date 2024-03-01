// internal packages
import 'package:gear_ui/src/local_storage/objects/cached_product.dart';

class CartProduct {
  int id;
  String name;
  String? avatar;
  int quantity;
  double price;

  CartProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    this.avatar,
  });

  factory CartProduct.fromCached(CachedProduct cachedProduct) {
    return CartProduct(
      id: cachedProduct.id,
      name: cachedProduct.name,
      price: cachedProduct.price,
      quantity: cachedProduct.quantity,
    );
  }
}
