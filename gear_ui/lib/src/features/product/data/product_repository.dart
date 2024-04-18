// external packages
import 'package:gear_ui/src/local_storage/obj/products/cached_product_detail.dart';
import 'package:hive_flutter/adapters.dart';

// internal packages
import 'package:gear_ui/src/local_storage/obj/products/cached_product.dart';
import 'package:gear_ui/src/local_storage/utils/cached_objects.dart';
import 'package:gear_ui/src/utils/pagination_param.dart';

class ProductRepository {
  final Box<CachedProduct> _productBox;
  final Box<CachedProductDetail> _productDetailBox;

  const ProductRepository._({
    required Box<CachedProduct> productBox,
    required Box<CachedProductDetail> productDetailBox,
  })  : _productBox = productBox,
        _productDetailBox = productDetailBox;

  static Future<ProductRepository> get instance async {
    return ProductRepository._(
      productBox: await CachedObjects.products,
      productDetailBox: await CachedObjects.productDetails,
    );
  }

  List<CachedProduct> get _cached => [..._productBox.values];

  Future<void> _updateCache(Iterable<CachedProduct> newCachedProducts) async {
    await _productBox
        .putAll({for (var product in newCachedProducts) product.id: product});
  }

  Future<List<CachedProduct>> findAll({PaginationParam? param}) async {
    // final response = <CachedProduct>[
    //   CachedProduct(
    //     id: 1,
    //     categoryId: 1,
    //     brandId: 1,
    //     code: "PRO01",
    //     name: "Adidas Predator 20.3",
    //     description: "abchk ahfjka ahdasl ashdjkashg akjshduakj dahdkja"
    //         " asjkhfkas  jk ashfksdk jsdhslg s  ghfdjkhgl sgfs ",
    //     price: 200,
    //     quantity: 100,
    //   ),
    //   CachedProduct(
    //     id: 2,
    //     categoryId: 1,
    //     brandId: 1,
    //     code: "PRO02",
    //     name: "Nike Mercurial",
    //     description: "abchk ahfjka ahdasl ashdjkashg akjshduakj dahdkja"
    //         " asjkhfkas  jk ashfksdk jsdhslg s  ghfdjkhgl sgfs ",
    //     price: 149,
    //     quantity: 100,
    //   ),
    //   CachedProduct(
    //     id: 3,
    //     categoryId: 1,
    //     brandId: 1,
    //     code: "PRO03",
    //     name: "ABC",
    //     description: "abchk ahfjka ahdasl ashdjkashg akjshduakj dahdkja"
    //         " asjkhfkas  jk ashfksdk jsdhslg s  ghfdjkhgl sgfs ",
    //     price: 149,
    //     quantity: 100,
    //   ),
    //   CachedProduct(
    //     id: 4,
    //     categoryId: 1,
    //     brandId: 1,
    //     code: "PRO04",
    //     name: "DEF",
    //     description: "abchk ahfjka ahdasl ashdjkashg akjshduakj dahdkja"
    //         " asjkhfkas  jk ashfksdk jsdhslg s  ghfdjkhgl sgfs ",
    //     price: 149,
    //     quantity: 100,
    //   ),
    //   CachedProduct(
    //     id: 5,
    //     categoryId: 1,
    //     brandId: 1,
    //     code: "PRO05",
    //     name: "GHI 05",
    //     description: "abchk ahfjka ahdasl ashdjkashg akjshduakj dahdkja"
    //         " asjkhfkas  jk ashfksdk jsdhslg s  ghfdjkhgl sgfs ",
    //     price: 149,
    //     quantity: 100,
    //   ),
    //   CachedProduct(
    //     id: 6,
    //     categoryId: 1,
    //     brandId: 1,
    //     code: "PRO05",
    //     name: "GHI 06",
    //     description: "abchk ahfjka ahdasl ashdjkashg akjshduakj dahdkja"
    //         " asjkhfkas  jk ashfksdk jsdhslg s  ghfdjkhgl sgfs ",
    //     price: 149,
    //     quantity: 100,
    //   ),
    //   CachedProduct(
    //     id: 7,
    //     categoryId: 1,
    //     brandId: 1,
    //     code: "PRO05",
    //     name: "GHI 07",
    //     description: "abchk ahfjka ahdasl ashdjkashg akjshduakj dahdkja"
    //         " asjkhfkas  jk ashfksdk jsdhslg s  ghfdjkhgl sgfs ",
    //     price: 149,
    //     quantity: 100,
    //   ),
    //   CachedProduct(
    //     id: 8,
    //     categoryId: 1,
    //     brandId: 1,
    //     code: "PRO05",
    //     name: "GHI 08",
    //     description: "abchk ahfjka ahdasl ashdjkashg akjshduakj dahdkja"
    //         " asjkhfkas  jk ashfksdk jsdhslg s  ghfdjkhgl sgfs ",
    //     price: 149,
    //     quantity: 100,
    //   ),
    //   CachedProduct(
    //     id: 9,
    //     categoryId: 1,
    //     brandId: 1,
    //     code: "PRO05",
    //     name: "GHI 09",
    //     description: "abchk ahfjka ahdasl ashdjkashg akjshduakj dahdkja"
    //         " asjkhfkas  jk ashfksdk jsdhslg s  ghfdjkhgl sgfs ",
    //     price: 149,
    //     quantity: 100,
    //   ),
    //   CachedProduct(
    //     id: 10,
    //     categoryId: 1,
    //     brandId: 1,
    //     code: "PRO05",
    //     name: "GHI 10",
    //     description: "abchk ahfjka ahdasl ashdjkashg akjshduakj dahdkja"
    //         " asjkhfkas  jk ashfksdk jsdhslg s  ghfdjkhgl sgfs ",
    //     price: 149,
    //     quantity: 100,
    //   ),
    // ];

    if (param != null) {
      if (_cached.length <= param.nextOffset) {
        // TODO: call api with pagination

        // TODO: update cache values
        // await _updateCache(response);
        // return response;
      } else {
        // TODO: load from cached.
        return [
          ..._cached.getRange(param.offset, param.page * param.size),
        ];
      }
    } else {
      // TODO: call api without pagination

      // TODO: update cache values
      // await _updateCache(response);
      // return response;
    }

    return [];
  }

  Future<CachedProduct?> findById(int id) async {
    CachedProduct? product = _productBox.get(id);

    if (product == null) {
      // TODO: call api -> replace for product
    }

    return product;
  }

  Future<List<CachedProduct>> findByName(
    String name, {
    int maxResultCount = 5,
  }) async {
    List<CachedProduct> result = _cached.where((product) {
      return product.name.toLowerCase().contains(name.toLowerCase());
    }).toList();

    if (result.length < maxResultCount) {
      // TODO: call api -> add to result -> update cached
    }

    return result;
  }
}
