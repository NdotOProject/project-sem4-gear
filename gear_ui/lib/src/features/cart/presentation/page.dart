import 'package:flutter/material.dart';

// external packages
import 'package:get/get.dart';

// internal packages
import 'package:gear_ui/src/features/cart/presentation/page_controller.dart';
import 'package:gear_ui/src/features/cart/presentation/cart_item.dart';
import 'package:gear_ui/src/layouts/children_page_layout.dart';

class CartPage extends GetView<CartPageController> {
  const CartPage({super.key});

  static const double _contentPadding = 10;
  static const double _dividerIndent = 10;
  static const double _floatingButtonSize = 60;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Obx(
      () => ChildrenPageLayout(
        body: RefreshIndicator.adaptive(
          onRefresh: controller.fetchData,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: _contentPadding,
            ),
            itemCount: controller.cartItems.length + 1,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                indent: _dividerIndent,
                endIndent: _dividerIndent,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              if (index < controller.cartItems.length) {
                return CartItem(
                  item: controller.cartItems[index],
                  onSelected: controller.selectItem,
                );
              } else {
                return Container(
                  height: 100,
                  alignment: Alignment.center,
                  child: const Text("No more"),
                );
              }
            },
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              controller.selectAllItems(!controller.isSelectAll);
            },
            child: const Text(
              "Select all",
            ),
          ),
          Checkbox(
            value: controller.isSelectAll,
            onChanged: controller.selectAllItems,
          ),
        ],
        floatingActionButton: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                width: _floatingButtonSize,
                height: _floatingButtonSize,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    controller.redirectToOrderReviewPage(context);
                  },
                  color: theme.primaryIconTheme.color,
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    size: _floatingButtonSize / 2,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: 25,
                  minHeight: 25,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  "${controller.selectedItems.length}",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
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
