import 'package:gear_ui/src/features/auth/domain/user.dart';
import 'package:gear_ui/src/features/cart/domain/cart_product.dart';
import 'package:gear_ui/src/utils/hive_boxes.dart';

/*
* add { signed in => post api, else => cache }
* findAll { signed in => get api, else => read cached }
*/
class CartRepository {
  final User? user;

  const CartRepository({
    this.user,
  });

  bool get isSignedIn => user != null;

  Future<List<CartProduct>> findAll() async {
    if (isSignedIn) {
      // TODO: call api with user id. => cache
      return [];
    } else {
      // TODO: check cached.
      // final cartBox = await HiveBoxes.cart;
      // return cartBox.values.toList();
      return [];
    }
  }

  Future<void> add(CartProduct product) async {
    if (isSignedIn) {
      // TODO: call api. => cache
    } else {
      // final cartBox = await HiveBoxes.cart;
      // cartBox.put(product.id, product);
    }
  }

  Future<bool> contains(CartProduct product) async {
    // final cartBox = await HiveBoxes.cart;
    // final cachedItem = cartBox.get(product.id);
    // return cachedItem == product;
    return false;
  }
}
