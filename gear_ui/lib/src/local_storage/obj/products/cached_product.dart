// external packages
import 'package:gear_ui/src/local_storage/obj/products/cached_brand.dart';
import 'package:gear_ui/src/local_storage/obj/products/cached_feedback.dart';
import 'package:gear_ui/src/local_storage/obj/products/cached_product_category.dart';
import 'package:gear_ui/src/local_storage/obj/products/cached_product_detail.dart';
import 'package:hive/hive.dart';

part 'cached_product.g.dart';

@HiveType(typeId: CachedProduct.typeId)
class CachedProduct extends HiveObject {
  static const int typeId = 1;
  static const String boxName = "products";

  // identifier fields
  @HiveField(0)
  int id;

  @HiveField(1)
  String code;

  // info fields
  @HiveField(2)
  CachedBrand brand;

  @HiveField(3)
  CachedProductCategory category;

  @HiveField(4)
  String name;

  @HiveField(5)
  String? description;

  @HiveField(6)
  double price;

  @HiveField(7)
  double rating;

  @HiveField(8)
  List<CachedFeedback> feedbacks;

  Set<CachedProductDetail> details;

  CachedProduct({
    required this.id,
    required this.code,
    required this.brand,
    required this.category,
    required this.name,
    this.description,
    this.price = 0.0,
    this.rating = 0.0,
    this.feedbacks = const <CachedFeedback>[],
    this.details = const <CachedProductDetail>{},
  });
}
