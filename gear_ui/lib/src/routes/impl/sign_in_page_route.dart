import 'package:flutter/widgets.dart';

// external packages
import 'package:go_router/go_router.dart';

// internal packages
import 'package:gear_ui/src/features/auth/presentation/sign_in.dart';
import 'package:gear_ui/src/routes/app_route.dart';

class SignInPageRoute extends AppRoute {
  static const String routeName = "SignInRoute";

  static const String routePath = "/sign-in";

  @override
  void asDestination({required BuildContext context}) {
    context.pushNamed(name);
  }

  @override
  Widget builder(BuildContext context, GoRouterState state) {
    return const SignIn();
  }

  @override
  String get name => routeName;

  @override
  String get path => routePath;
}
