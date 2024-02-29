import 'package:flutter/material.dart';

// external packages
import 'package:hive/hive.dart';

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
    required this.price,
    this.rating = 0.0,
    this.imageUrls,
    this.avatarImageUrl,
    this.sizeIds = const [],
    this.colorIds = const [],
    this.feedbackIds = const [],
    this.quantity = 0,
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
  double price;

  @HiveField(7)
  double rating;

  @HiveField(8)
  List<String>? imageUrls;

  @HiveField(9)
  String? avatarImageUrl;

  @HiveField(10)
  List<int> sizeIds;

  @HiveField(11)
  List<int> colorIds;

  @HiveField(12)
  List<int> feedbackIds;

  @HiveField(13)
  int quantity;

  static const Map<int, Color> colorData = <int, Color>{
    1: Colors.black,
    2: Colors.white,
    3: Colors.red,
    4: Colors.pink,
    5: Colors.purple,
    6: Colors.deepPurple,
    7: Colors.indigo,
    8: Colors.blue,
    9: Colors.lightBlue,
    10: Colors.cyan,
    11: Colors.teal,
    12: Colors.green,
    13: Colors.lightGreen,
    14: Colors.lime,
    15: Colors.yellow,
    16: Colors.amber,
    17: Colors.orange,
    18: Colors.deepOrange,
    19: Colors.brown,
    20: Colors.grey,
    21: Colors.blueGrey,
  };
}
