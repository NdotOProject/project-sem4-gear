// external packages
import 'package:hive/hive.dart';

// internal packages
import 'package:gear_ui/src/local_storage/obj/products/cached_product_color.dart';
import 'package:gear_ui/src/local_storage/utils/cached_objects.dart';

class ProductColorRepository {
  final Box<CachedProductColor> _productColorBox;

  const ProductColorRepository._(this._productColorBox);

  static Future<ProductColorRepository> get instance async {
    return ProductColorRepository._(await CachedObjects.productColors);
  }

  Map<int, CachedProductColor> get _cached => {..._productColorBox.toMap()};

  Future<List<CachedProductColor>> findAllByProductId(int productId) async {
    final data = <CachedProductColor>[
      CachedProductColor(
        id: 1,
        name: "Red",
      ),
      CachedProductColor(
        id: 2,
        name: "Black",
      ),
      CachedProductColor(
        id: 3,
        name: "Blue",
      ),
      CachedProductColor(
        id: 4,
        name: "White",
      ),
      CachedProductColor(
        id: 5,
        name: "Green",
      ),
      CachedProductColor(
        id: 6,
        name: "Yellow",
      ),
    ];

    await _productColorBox.putAll({for (var color in data) color.id: color});

    return [];
  }

  Future<CachedProductColor?> findById(int id) async {
    CachedProductColor? color = _cached[id];

    if (color == null) {
      // TODO: call api
    }

    return color;
  }
}
