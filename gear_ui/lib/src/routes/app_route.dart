import 'package:gear_ui/src/views/home/home.dart';
import 'package:gear_ui/src/views/sign_in/sign_in.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes {
  home(
    name: "home",
    path: "/",
  ),
  signIn(
    name: "signIn",
    path: "/sign-in",
  ),
  ;

  final String name;
  final String path;

  const AppRoutes({
    required this.name,
    required this.path,
  });

  static List<GoRoute> get routes {
    return <GoRoute>[
      GoRoute(
        path: home.path,
        name: home.name,
        builder: (context, state) {
          return const Home();
        },
      ),
      GoRoute(
        path: signIn.path,
        name: signIn.name,
        builder: (context, state) {
          return const SignIn();
        },
      ),
    ];
  }
}
