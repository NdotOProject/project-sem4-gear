import 'package:flutter/material.dart';
import 'package:gear_ui/src/routes/app_route.dart';
import 'package:gear_ui/src/views/layouts/layout.dart';

class SignIn extends StatelessWidget {
  const SignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Layout(
      selectedSideBarItem: AppRoutes.signIn,
      body: Center(
        child: Text("Sign In"),
      ),
    );
  }
}
