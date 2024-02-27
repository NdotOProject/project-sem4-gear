import 'dart:ui';

class CartProduct {
  CartProduct({
    required this.id,
    required this.name,
    required this.size,
    required this.color,
    required this.price,
    required this.quantity,
    this.avatar,
  });

  int id;
  String name;
  String? avatar;
  int size;
  Color color;
  int quantity;
  double price;

  double get totalAmount {
    return quantity * price;
  }
}
