// external packages
import 'package:hive/hive.dart';

// internal packages
import 'package:gear_ui/src/local_storage/objects/cached_product_color.dart';
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
        productIds: <int>[1, 2, 3, 4, 5],
      ),
      CachedProductColor(
        id: 2,
        name: "Black",
        productIds: <int>[2, 3, 4, 5, 6],
      ),
      CachedProductColor(
        id: 3,
        name: "Blue",
        productIds: <int>[3, 4, 5, 6, 7],
      ),
      CachedProductColor(
        id: 4,
        name: "White",
        productIds: <int>[4, 5, 6, 7, 8],
      ),
      CachedProductColor(
        id: 5,
        name: "Green",
        productIds: <int>[5, 6, 7, 8, 9],
      ),
      CachedProductColor(
        id: 6,
        name: "Yellow",
        productIds: <int>[6, 7, 8, 9, 10],
      ),
    ];

    await _productColorBox.putAll({for (var color in data) color.id: color});

    return [
      ..._cached.values.where(
        (productColor) => productColor.productIds.contains(productId),
      )
    ];
  }

  Future<CachedProductColor?> findById(int id) async {
    CachedProductColor? color = _cached[id];

    if (color == null) {
      // TODO: call api
    }

    return color;
  }
}
