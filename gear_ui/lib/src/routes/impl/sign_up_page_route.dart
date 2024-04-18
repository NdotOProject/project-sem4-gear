import 'package:flutter/widgets.dart';

// external packages
import 'package:go_router/go_router.dart';

// internal packages
import 'package:gear_ui/src/features/auth/presentation/sign_up/page.dart';
import 'package:gear_ui/src/routes/app_route.dart';

class SignUpPageRoute extends AppRoute {
  static const String routeName = "SignUpPageRoute";

  static const String routePath = "/sign-up";

  @override
  void asDestination({required BuildContext context}) {
    context.pushNamed(name);
  }

  @override
  Widget builder(BuildContext context, GoRouterState state) {
    return const SignUp();
  }

  @override
  String get name => routeName;

  @override
  String get path => routePath;
}
