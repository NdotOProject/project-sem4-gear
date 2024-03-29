import 'package:flutter/widgets.dart';

// external packages
import 'package:go_router/go_router.dart';

// internal packages
import 'package:gear_ui/src/features/search/presentation/search_page.dart';
import 'package:gear_ui/src/routes/app_route.dart';

class SearchPageRoute extends AppRoute {
  @override
  void asDestination({required BuildContext context}) {
    context.pushNamed(name);
  }

  @override
  Widget builder(BuildContext context, GoRouterState state) {
    return const SearchPage();
  }

  @override
  String get name => "SearchPageRoute";

  @override
  String get path => "/search";
}
