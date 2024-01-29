import 'package:flutter/material.dart';

class ChildrenPageLayout extends StatelessWidget {
  const ChildrenPageLayout({
    super.key,
    required this.body,
    this.title,
  });

  final Widget body;
  final Widget? title;

  static const double _iconThemeSize = 30.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: title,
        iconTheme: const IconThemeData(
          size: _iconThemeSize,
        ),
      ),
      body: SafeArea(
        child: body,
      ),
    );
  }
}
