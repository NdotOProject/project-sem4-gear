import 'package:hive/hive.dart';

part 'cached_cart_item.g.dart';

@HiveType(typeId: CachedCartItem.typeId)
class CachedCartItem extends HiveObject {
  static const int typeId = 2;

  @HiveField(0)
  int? id;

  @HiveField(1)
  int productId;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  bool selected;

  @HiveField(4)
  int? sizeId;

  @HiveField(5)
  int? colorId;

  @HiveField(6)
  double? price;

  CachedCartItem({
    this.id,
    required this.productId,
    this.quantity = 1,
    this.selected = false,
  });

  @override
  String toString() {
    return 'CachedCartItem{productId: $productId, quantity: $quantity, selected: $selected, sizeId: $sizeId, colorId: $colorId}';
  }
}
