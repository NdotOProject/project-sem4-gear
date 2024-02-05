import 'package:flutter/material.dart';
import 'package:gear_ui/src/layouts/children_page_layout.dart';
import 'package:gear_ui/src/layouts/main_page_layout.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({
    super.key,
    required this.message,
    this.childrenPage = false,
  });

  final String message;
  final bool childrenPage;

  @override
  Widget build(BuildContext context) {
    final body = Center(
      child: Text(message),
    );
    return childrenPage
        ? ChildrenPageLayout(body: body)
        : MainPageLayout(body: body);
  }
}
