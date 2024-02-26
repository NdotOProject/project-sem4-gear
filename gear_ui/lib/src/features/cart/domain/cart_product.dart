import 'package:hive/hive.dart';

import 'package:gear_ui/src/configurations/hive_config.dart';

part 'cart_product.g.dart';

@HiveType(typeId: cartProductTypeId)
class CartProduct {
  CartProduct({
    required this.id,
    required this.name,
    required this.size,
    required this.price,
    required this.quantity,
    this.avatar,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? avatar;

  @HiveField(3)
  int size;

  @HiveField(4)
  int quantity;

  @HiveField(5)
  double price;

  double get totalAmount {
    return quantity * price;
  }
}
