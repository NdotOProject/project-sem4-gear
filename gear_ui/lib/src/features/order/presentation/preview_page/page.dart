import 'package:flutter/material.dart';
import 'package:gear_ui/src/features/auth/domain/signed_in_user.dart';
import 'package:gear_ui/src/features/order/domain/order_preview_item.dart';
import 'package:gear_ui/src/layouts/children_page_layout.dart';
import 'package:gear_ui/src/routes/app_routes.dart';

class OrderPreviewPage extends StatelessWidget {
  OrderPreviewPage({
    super.key,
    required this.items,
    this.user,
  });

  final List<OrderPreviewItem> items;
  final List<String> paymentMethods = ["Cash", "Paypal"];
  final SignedInUser? user;

  static const double _bottomSheetHeight = 50;
  static const double _bottomSheetBorderWidth = 0.5;

  double get _totalAmount {
    return items.fold(0.0, (previousValue, element) {
      return previousValue += element.price;
    });
  }

  void _handleBuy(BuildContext context) {
    if (user == null) {
      AppRoutes.signIn.asDestination(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ChildrenPageLayout(
      bottomSheet: SizedBox(
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
                  child: DropdownMenu(
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
                      })
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "\$$_totalAmount",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: ListView.separated(
          itemCount: items.length + 1,
          itemBuilder: (context, index) {
            if (index < items.length) {
              return SizedBox(
                height: 100,
                child: Card(
                  child: Text("${items[index]}"),
                ),
              );
            } else {
              return const SizedBox(
                height: _bottomSheetHeight + _bottomSheetBorderWidth,
              );
            }
          },
          separatorBuilder: (context, index) {
            if (index < items.length - 1) {
              return const Divider();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
