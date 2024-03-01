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
  static const double _floatingButtonPadding = 5;
  static const double _selectedItemCountMessageSize = 25;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Widget floatingButton = Obx(
      () => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(_floatingButtonPadding),
            child: SizedBox(
              width: _floatingButtonSize,
              height: _floatingButtonSize,
              child: IconButton(
                onPressed: () {
                  controller.redirectToOrderReviewPage(context);
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  size: _floatingButtonSize / 2,
                ),
                color: theme.primaryIconTheme.color,
                style: IconButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                ),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: _selectedItemCountMessageSize,
              height: _selectedItemCountMessageSize,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(
                  _selectedItemCountMessageSize,
                ),
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
    );

    return Obx(
      () => ChildrenPageLayout(
        body: RefreshIndicator.adaptive(
          onRefresh: controller.fetchData,
          child: controller.cartItems.isEmpty
              ? const Center(
                  child: Text(
                    "No items",
                  ),
                )
              : ListView.separated(
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
                        height:
                            _floatingButtonSize + (_floatingButtonPadding * 2),
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
            child: Text(
              controller.isSelectAll ? "Clear all" : "Select all",
            ),
          ),
          Checkbox.adaptive(
            value: controller.isSelectAll,
            onChanged: controller.selectAllItems,
          ),
        ],
        floatingActionButton: floatingButton,
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
