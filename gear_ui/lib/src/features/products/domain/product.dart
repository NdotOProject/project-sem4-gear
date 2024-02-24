import 'package:gear_ui/src/configurations/hive_config.dart';
import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: productTypeId)
class Product extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int categoryId;

  @HiveField(2)
  int brandId;

  @HiveField(3)
  String code;

  @HiveField(4)
  String name;

  @HiveField(5, defaultValue: "No Description")
  String? description;

  @HiveField(7)
  double price;

  @HiveField(8, defaultValue: 0.0)
  double? rating;

  @HiveField(9, defaultValue: 0)
  int? quantity;

  @HiveField(10, defaultValue: <String>[])
  List<String>? images;

  Product({
    this.id,
    required this.categoryId,
    required this.brandId,
    required this.code,
    required this.name,
    this.description,
    required this.price,
    this.rating,
    this.quantity,
  });

  @override
  String toString() {
    return 'Product{id: $id, categoryId: $categoryId, brandId: $brandId, code: $code, name: $name, description: $description, price: $price, rating: $rating, quantity: $quantity}';
  }
}
