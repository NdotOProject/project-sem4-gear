import 'package:hive/hive.dart';

part 'cached_product_size.g.dart';

@HiveType(typeId: CachedProductSize.typeId)
class CachedProductSize extends HiveObject {
  static const int typeId = 3;

  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? description;

  @HiveField(3)
  List<int> productIds;

  CachedProductSize({
    required this.id,
    required this.name,
    this.description,
    required this.productIds,
  });

  @override
  String toString() {
    return 'CachedProductSize{id: $id, name: $name, description: $description, productIds: $productIds}';
  }
}
