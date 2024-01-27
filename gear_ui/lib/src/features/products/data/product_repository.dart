import 'package:gear_ui/src/features/products/domain/product.dart';
import 'package:gear_ui/src/utils/hive_boxes.dart';
import 'package:gear_ui/src/utils/pagination_param.dart';

class ProductRepository {
  const ProductRepository();

  Future<List<Product>> findAll({PaginationParam? param}) async {
    final products = await HiveBoxes.products;

    final response = <Product>[
      Product(
        id: 1,
        categoryId: 1,
        brandId: 1,
        code: "PRO01",
        name: "Adidas Predator 20.3",
        price: 200,
      ),
      Product(
        id: 2,
        categoryId: 1,
        brandId: 1,
        code: "PRO02",
        name: "Nike Mercurial",
        price: 149,
      ),
      Product(
        id: 3,
        categoryId: 1,
        brandId: 1,
        code: "PRO03",
        name: "ABC",
        price: 149,
      ),
      Product(
        id: 4,
        categoryId: 1,
        brandId: 1,
        code: "PRO04",
        name: "DEF",
        price: 149,
      ),
      Product(
        id: 5,
        categoryId: 1,
        brandId: 1,
        code: "PRO05",
        name: "GHI",
        price: 149,
      ),
      Product(
        id: 6,
        categoryId: 1,
        brandId: 1,
        code: "PRO05",
        name: "GHI",
        price: 149,
      ),
      Product(
        id: 7,
        categoryId: 1,
        brandId: 1,
        code: "PRO05",
        name: "GHI",
        price: 149,
      ),
      Product(
        id: 8,
        categoryId: 1,
        brandId: 1,
        code: "PRO05",
        name: "GHI",
        price: 149,
      ),
      Product(
        id: 9,
        categoryId: 1,
        brandId: 1,
        code: "PRO05",
        name: "GHI",
        price: 149,
      ),
    ];
    if (param != null) {
      final cachedProducts = products.values.toList();
      if (cachedProducts.length <= param.offset) {
        // TODO: call api with pagination

        // update cache values
        await products
            .putAll({for (var product in response) product.id: product});
        return response;
      } else {
        // get from cache
        return cachedProducts
            .getRange(param.offset, param.page * param.size)
            .toList();
      }
    } else {
      // TODO: call api without pagination
      // cache values
      await products
          .putAll({for (var product in response) product.id: product});
      return response;
    }
  }

  Future<Product> findById(int id) async {
    final products = await HiveBoxes.products;
    return products.get(id) ??
        // TODO: throw error
        Product(
          categoryId: 1,
          brandId: 1,
          code: "code",
          name: "name",
          price: 1,
        );
  }
}
