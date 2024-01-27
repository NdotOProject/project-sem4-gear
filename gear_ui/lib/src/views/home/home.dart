import 'package:flutter/material.dart';
import 'package:gear_ui/src/features/products/presentation/product_list.dart';
import 'package:gear_ui/src/routes/app_route.dart';
import 'package:gear_ui/src/views/layouts/layout.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      selectedSideBarItem: AppRoutes.home,
      body: const Center(
        child: ProductList(),
      ),
    );
  }
}
