// external packages
import 'package:hive/hive.dart';

// internal packages
import 'package:gear_ui/src/local_storage/objects/cached_product_size.dart';
import 'package:gear_ui/src/local_storage/utils/cached_objects.dart';

class ProductSizeRepository {
  final Box<CachedProductSize> _productSizeBox;

  const ProductSizeRepository._(this._productSizeBox);

  static Future<ProductSizeRepository> get instance async {
    return ProductSizeRepository._(await CachedObjects.productSizes);
  }

  Future<List<CachedProductSize>> findAllByProductId(int productId) async {
    final data = <CachedProductSize>[
      CachedProductSize(
        id: 1,
        name: "37",
        productIds: <int>[1, 2, 3, 4, 5],
      ),
      CachedProductSize(
        id: 1,
        name: "38",
        productIds: <int>[2, 3, 4, 5, 6],
      ),
      CachedProductSize(
        id: 2,
        name: "39",
        productIds: <int>[3, 4, 5, 6, 7],
      ),
      CachedProductSize(
        id: 3,
        name: "40",
        productIds: <int>[4, 5, 6, 7, 8],
      ),
      CachedProductSize(
        id: 4,
        name: "41",
        productIds: <int>[5, 6, 7, 8, 9],
      ),
      CachedProductSize(
        id: 5,
        name: "42",
        productIds: <int>[6, 7, 8, 9, 10],
      ),
    ];

    await _productSizeBox.putAll({for (var size in data) size.id: size});

    return [
      ...data.where(
        (productSize) => productSize.productIds.contains(productId),
      )
    ];
  }

  Future<CachedProductSize?> findById(int id) async {
    CachedProductSize? productSize = _productSizeBox.get(id);

    if (productSize == null) {
      // TODO: call api
    }

    return productSize;
  }
}
