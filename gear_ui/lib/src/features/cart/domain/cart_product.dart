// internal packages
import 'package:gear_ui/src/local_storage/obj/products/cached_product.dart';

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

  factory CartProduct.fromCached(CachedProduct cached) {
    return CartProduct(
      id: cached.id,
      name: cached.name,
      price: cached.price,
      quantity: 0,
    );
  }
}
