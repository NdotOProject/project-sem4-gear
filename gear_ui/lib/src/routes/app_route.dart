import 'package:flutter/widgets.dart';

// external packages
import 'package:go_router/go_router.dart';

abstract class AppRoute {
  String get path;

  String get name;

  @protected
  void asDestination({required BuildContext context});

  Widget builder(BuildContext context, GoRouterState state);
}
