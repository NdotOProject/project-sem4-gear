// external packages
import 'package:hive/hive.dart';

part 'cached_product.g.dart';

@HiveType(typeId: CachedProduct.typeId)
class CachedProduct extends HiveObject {
  static const int typeId = 1;

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
}
