import 'package:gear_ui/src/features/product/domain/home_product.dart';
import 'package:gear_ui/src/utils/hive_boxes.dart';
import 'package:gear_ui/src/utils/pagination_param.dart';

class ProductRepository {
  const ProductRepository();

  Future<List<HomeProduct>> findAll({PaginationParam? param}) async {
    final products = await HiveBoxes.products;

    final response = <HomeProduct>[
      HomeProduct(
        id: 1,
        // categoryId: 1,
        // brandId: 1,
        // code: "PRO01",
        name: "Adidas Predator 20.3",
        description: "abchk ahfjka ahdasl ashdjkashg akjshduakj dahdkja"
            " asjkhfkas  jk ashfksdk jsdhslg s  ghfdjkhgl sgfs ",
        price: 200,
      ),
      HomeProduct(
        id: 2,
        // categoryId: 1,
        // brandId: 1,
        // code: "PRO02",
        name: "Nike Mercurial",
        price: 149,
      ),
      HomeProduct(
        id: 3,
        // categoryId: 1,
        // brandId: 1,
        // code: "PRO03",
        name: "ABC",
        price: 149,
      ),
      HomeProduct(
        id: 4,
        // categoryId: 1,
        // brandId: 1,
        // code: "PRO04",
        name: "DEF",
        price: 149,
      ),
      HomeProduct(
        id: 5,
        // categoryId: 1,
        // brandId: 1,
        // code: "PRO05",
        name: "GHI 05",
        price: 149,
      ),
      HomeProduct(
        id: 6,
        // categoryId: 1,
        // brandId: 1,
        // code: "PRO05",
        name: "GHI 06",
        price: 149,
      ),
      HomeProduct(
        id: 7,
        // categoryId: 1,
        // brandId: 1,
        // code: "PRO05",
        name: "GHI 07",
        price: 149,
      ),
      HomeProduct(
        id: 8,
        // categoryId: 1,
        // brandId: 1,
        // code: "PRO05",
        name: "GHI 08",
        price: 149,
      ),
      HomeProduct(
        id: 9,
        // categoryId: 1,
        // brandId: 1,
        // code: "PRO05",
        name: "GHI 09",
        price: 149,
      ),
      HomeProduct(
        id: 10,
        // categoryId: 1,
        // brandId: 1,
        // code: "PRO05",
        name: "GHI 10",
        price: 149,
      ),
    ];
    if (param != null) {
      final cachedProducts = products.values.toList();
      if (cachedProducts.length <= param.offset) {
        // TODO: call api with pagination -> update cache values

        await products
            .putAll({for (var product in response) product.id: product});
        return response;
      } else {
        // get from cached
        return cachedProducts
            .getRange(param.offset, param.page * param.size)
            .toList();
      }
    } else {
      // TODO: call api without pagination -> update cache values

      await products
          .putAll({for (var product in response) product.id: product});
      return response;
    }
  }

  Future<HomeProduct?> findById(int id) async {
    final products = await HiveBoxes.products;
    HomeProduct? product = products.get(id);
    if (product == null) {
      // TODO: call api -> replace for product
    }
    return product;
  }

  Future<List<HomeProduct>> findByName(
    String name, {
    int maxResultCount = 5,
  }) async {
    final products = await HiveBoxes.products;
    List<HomeProduct> result = products.values.where((product) {
      return product.name.toLowerCase().contains(name.toLowerCase());
    }).toList();

    if (result.length < maxResultCount) {
      // TODO: call api -> add to result -> update cached
    }

    return result;
  }
}
