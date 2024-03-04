import 'package:flutter/material.dart';
import 'package:gear_ui/src/routes/app_routes.dart';

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
  // static const double _floatingButtonSize = 60;
  // static const double _floatingButtonPadding = 5;
  // static const double _selectedItemCountMessageSize = 25;

  static const double _bottomSheetHeight = 50;
  static const double _bottomSheetBorderWidth = 0.5;

  static const List<String> paymentMethods = ["Cash", "Paypal"];

  void _handleBuy(BuildContext context) {
    // if (user == null) {
    AppRoutes.signIn.asDestination(context: context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    const Widget emptyItemsWidget = Center(
      child: Text(
        "No items",
      ),
    );

    final Widget allItemsControlWidget = Obx(
      () => Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              controller.handleSelectAllItems(!controller.selectedAll);
            },
            child: Text(
              controller.selectedAll ? "Clear all" : "Select all",
            ),
          ),
          Checkbox.adaptive(
            value: controller.selectedAll,
            onChanged: controller.handleSelectAllItems,
          ),
        ],
      ),
    );

    final Widget paymentMethodOptionsWidget = DropdownMenu(
      initialSelection: paymentMethods[0],
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.only(left: 10),
        border: InputBorder.none,
        outlineBorder: BorderSide.none,
        filled: true,
        fillColor: theme.cardColor,
      ),
      menuStyle: const MenuStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.zero),
      ),
      expandedInsets: EdgeInsets.zero,
      dropdownMenuEntries: [
        ...paymentMethods.map((method) {
          return DropdownMenuEntry(
            value: method,
            label: method,
          );
        }),
      ],
    );

    final Widget bottomSheetWidget = Obx(
      () => SizedBox(
        height: _bottomSheetHeight + _bottomSheetBorderWidth,
        child: Container(
          padding: const EdgeInsets.only(top: _bottomSheetBorderWidth),
          color: theme.shadowColor,
          child: ColoredBox(
            color: theme.cardColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: paymentMethodOptionsWidget,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Total: ${controller.totalAmount}",
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: _bottomSheetHeight,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        backgroundColor: theme.primaryColor,
                        foregroundColor: theme.colorScheme.onPrimary,
                      ),
                      onPressed: () {
                        _handleBuy(context);
                      },
                      child: const Text(
                        "Buy",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return Obx(
      () => ChildrenPageLayout(
        body: RefreshIndicator.adaptive(
          onRefresh: controller.fetchData,
          child: controller.allItems.isEmpty
              ? emptyItemsWidget
              : ListView.separated(
                  itemCount: controller.allItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CartItem(
                      item: controller.allItems[index],
                      onSelected: controller.handleSelectItem,
                      onQuantityChange: controller.handleItemQuantityChange,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      indent: _dividerIndent,
                      endIndent: _dividerIndent,
                    );
                  },
                  padding: const EdgeInsets.only(
                    left: _contentPadding,
                    right: _contentPadding,
                    bottom: _bottomSheetHeight + _bottomSheetBorderWidth,
                  ),
                ),
        ),
        actions: <Widget>[
          allItemsControlWidget,
        ],
        bottomSheet: bottomSheetWidget,
      ),
    );
  }
}
