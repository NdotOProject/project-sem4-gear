import 'package:gear_ui/src/local_storage/obj/products/cached_product_color.dart';
import 'package:gear_ui/src/local_storage/obj/products/cached_product_image.dart';
import 'package:gear_ui/src/local_storage/obj/products/cached_product_size.dart';
import 'package:hive/hive.dart';

part 'cached_product_detail.g.dart';

@HiveType(typeId: CachedProductDetail.typeId)
class CachedProductDetail extends HiveObject {
  static const int typeId = 2;
  static const String boxName = "productDetails";

  @HiveField(0)
  int id;

  @HiveField(1)
  int productId;

  @HiveField(2)
  CachedProductSize size;

  @HiveField(3)
  CachedProductColor color;

  @HiveField(4)
  List<CachedProductImage> images;

  @HiveField(5)
  int quantity;

  CachedProductDetail({
    required this.id,
    required this.productId,
    required this.size,
    required this.color,
    this.images = const <CachedProductImage>[],
    this.quantity = 0,
  });

  CachedProductImage? get avatar {
    return images.where((img) {
      return img.avatar;
    }).firstOrNull;
  }
}
