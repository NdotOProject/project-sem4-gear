import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gear_ui/src/features/cart/data/cart_repository.dart';

// internal packages
import 'package:gear_ui/src/features/cart/domain/cart_product.dart';
import 'package:gear_ui/src/features/cart/presentation/cart_item.dart';
import 'package:gear_ui/src/layouts/children_page_layout.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartRepository _cartRepository = const CartRepository();

  List<CartProduct> _products = [];

  List<CartProduct> _selectedItems = <CartProduct>[];

  bool get _selectAll {
    return listEquals(_selectedItems, _products);
  }

  void _handleSelectAll(bool? value) {
    setState(() {
      _selectedItems.clear();
      if (value != null && value) {
        _selectedItems = _products;
      }
    });
  }

  void _handleSelectItem(bool? selected, CartProduct product) {
    setState(() {
      if (selected != null && selected) {
        _selectedItems.add(product);
      } else {
        _selectedItems.remove(product);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _cartRepository.findAll().then((value) {
      // setState(() {
      _products = value;
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ChildrenPageLayout(
      body: ListView.separated(
        itemCount: _products.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            indent: 10,
            endIndent: 10,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          final CartProduct product = _products[index];
          return CartItem(
            product: product,
            onSelected: (value) {
              _handleSelectItem(value, product);
            },
            selected: _selectedItems.contains(product),
          );
        },
      ),
      actions: <Widget>[
        Text(
          "(${_selectedItems.length})",
        ),
        Checkbox(
          value: _selectAll,
          onChanged: _handleSelectAll,
        ),
      ],
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
