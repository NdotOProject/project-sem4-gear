import 'package:hive/hive.dart';

part 'cached_brand.g.dart';

@HiveType(typeId: CachedBrand.typeId)
class CachedBrand extends HiveObject {
  static const int typeId = 7;
  static const String boxName = "brands";

  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? description;

  CachedBrand({
    required this.id,
    required this.name,
    this.description,
  });
}
