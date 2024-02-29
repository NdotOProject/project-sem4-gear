import 'package:flutter/material.dart';
import 'package:gear_ui/src/features/order/domain/order_preview_item.dart';
import 'package:gear_ui/src/layouts/children_page_layout.dart';

class OrderPreviewPage extends StatelessWidget {
  const OrderPreviewPage({
    super.key,
    required this.items,
  });

  final List<OrderPreviewItem> items;

  @override
  Widget build(BuildContext context) {
    return ChildrenPageLayout(
      body: Center(
        child: Text("$items"),
      ),
    );
  }
}
