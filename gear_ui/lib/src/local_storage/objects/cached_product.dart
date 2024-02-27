// external packages
import 'package:flutter/material.dart';
import 'package:gear_ui/src/features/product/domain/home_product.dart';
import 'package:hive/hive.dart';

// internal packages
import 'package:gear_ui/src/features/cart/domain/cart_product.dart';
import 'package:gear_ui/src/features/product/domain/detail_product.dart';

part 'cached_product.g.dart';

@HiveType(typeId: CachedProduct.typeId)
class CachedProduct extends HiveObject {
  static const int typeId = 1;

  CachedProduct({
    required this.id,
    required this.code,
    required this.brandId,
    required this.categoryId,
    required this.name,
    this.description,
    this.avatar,
    this.images,
    required this.color,
    this.size = 0,
    required this.price,
    this.rating = 0.0,
    this.cartQuantity = 0,
    this.currentQuantity = 0,
    this.feedbacks = const [],
  });

  // identifier fields
  @HiveField(0)
  int id;

  @HiveField(1)
  String code;

  // info fields
  @HiveField(2)
  int brandId;

  @HiveField(3)
  int categoryId;

  @HiveField(4)
  String name;

  @HiveField(5)
  String? description;

  @HiveField(6)
  String? avatar;

  @HiveField(7)
  List<String>? images;

  @HiveField(8)
  int size;

  @HiveField(9)
  String color;

  @HiveField(10)
  double price;

  @HiveField(11)
  int currentQuantity;

  @HiveField(12)
  int cartQuantity;

  @HiveField(13)
  double rating;

  @HiveField(14)
  List<int> feedbacks;

  static const Map<String, Color> _colors = <String, Color>{
    "black": Colors.black,
    "white": Colors.white,
    "red": Colors.red,
    "pink": Colors.pink,
    "purple": Colors.purple,
    "deepPurple": Colors.deepPurple,
    "indigo": Colors.indigo,
    "blue": Colors.blue,
    "lightBlue": Colors.lightBlue,
    "cyan": Colors.cyan,
    "teal": Colors.teal,
    "green": Colors.green,
    "lightGreen": Colors.lightGreen,
    "lime": Colors.lime,
    "yellow": Colors.yellow,
    "amber": Colors.amber,
    "orange": Colors.orange,
    "deepOrange": Colors.deepOrange,
    "brown": Colors.brown,
    "grey": Colors.grey,
    "blueGrey": Colors.blueGrey,
  };

  HomeProduct get homeProduct {
    return HomeProduct(
      id: id,
      name: name,
      price: price,
    );
  }

  DetailProduct get detailProduct {
    return DetailProduct(
      name: name,
      price: price,
    );
  }

  CartProduct get cartProduct {
    return CartProduct(
      id: id,
      name: name,
      size: size,
      color: _colors[color] ?? Colors.transparent,
      price: price,
      quantity: cartQuantity,
    );
  }
}
