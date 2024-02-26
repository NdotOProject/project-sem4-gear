import 'package:flutter/material.dart';

// internal packages
import 'package:gear_ui/src/features/cart/domain/cart_product.dart';
import 'package:gear_ui/src/features/cart/presentation/cart_item.dart';
import 'package:gear_ui/src/layouts/children_page_layout.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final List<CartProduct> products = [
    CartProduct(
      name: "P1",
      price: 100029,
      id: 1,
      size: 43,
      quantity: 1,
    ),
    CartProduct(
      name: "P2",
      price: 48028,
      id: 2,
      size: 40,
      quantity: 2,
    ),
    CartProduct(
      name: "P3",
      price: 19734,
      id: 3,
      size: 43,
      quantity: 10,
    ),
    CartProduct(
      name: "P4",
      price: 80280,
      id: 1,
      size: 43,
      quantity: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ChildrenPageLayout(
      body: ListView.separated(
        itemCount: products.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            indent: 10,
            endIndent: 10,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return CartItem(
            product: products[index],
          );
        },
      ),
      floatingActionButton: IconButton(
        onPressed: () {},
        color: theme.primaryIconTheme.color,
        icon: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(
            Icons.shopping_cart_outlined,
            size: 30,
          ),
        ),
        style: IconButton.styleFrom(
          backgroundColor: theme.primaryColor,
        ),
      ),
    );
  }
}

/*
Focus(
    onKey: (node, event) {
      if (_quantityTextController.text.length == 1 &&
          event.isKeyPressed(LogicalKeyboardKey.backspace)) {
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    },
    child:
),
*/
