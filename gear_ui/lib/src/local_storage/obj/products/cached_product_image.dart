import 'package:hive/hive.dart';

part 'cached_product_image.g.dart';

@HiveType(typeId: CachedProductImage.typeId)
class CachedProductImage extends HiveObject {
  static const int typeId = 5;

  @HiveField(0)
  int id;

  @HiveField(1)
  String url;

  @HiveField(2)
  bool avatar;

  CachedProductImage({
    required this.id,
    required this.url,
    this.avatar = false,
  });
}
