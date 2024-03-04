import 'package:gear_ui/src/local_storage/objects/cached_user.dart';

class SignInUser {
  String email;
  String password;
  bool remember;

  SignInUser({
    required this.email,
    required this.password,
    required this.remember,
  });

  factory SignInUser.fromCached(CachedUser? cached) {
    return SignInUser(
      email: cached?.email ?? "",
      password: cached?.password ?? "",
      remember: cached?.remember ?? false,
    );
  }
}
