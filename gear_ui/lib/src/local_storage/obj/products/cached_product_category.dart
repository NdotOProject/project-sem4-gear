import 'package:hive/hive.dart';

part 'cached_product_category.g.dart';

@HiveType(typeId: CachedProductCategory.typeId)
class CachedProductCategory extends HiveObject {
  static const int typeId = 3;

  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? description;

  CachedProductCategory({
    required this.id,
    required this.name,
    this.description,
  });
}
