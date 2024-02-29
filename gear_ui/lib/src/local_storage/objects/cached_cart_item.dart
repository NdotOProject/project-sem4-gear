import 'package:hive/hive.dart';

part 'cached_cart_item.g.dart';

@HiveType(typeId: CachedCartItem.typeId)
class CachedCartItem extends HiveObject {
  static const int typeId = 2;

  @HiveField(0)
  int productId;

  @HiveField(1)
  int quantity;

  @HiveField(2)
  bool selected;

  CachedCartItem({
    required this.productId,
    this.quantity = 1,
    this.selected = false,
  });

  @override
  String toString() {
    return 'CachedCartItem{productId: $productId, quantity: $quantity, selected: $selected}';
  }
}
