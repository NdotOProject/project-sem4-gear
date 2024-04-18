import 'package:gear_ui/src/local_storage/obj/users/cached_user.dart';

class SignInRequest {
  String email;
  String password;
  bool remember;

  SignInRequest({
    required this.email,
    required this.password,
    required this.remember,
  });

  factory SignInRequest.fromCached(CachedUser? cached) {
    return SignInRequest(
      email: cached?.email ?? "",
      password: cached?.password ?? "",
      remember: cached?.remember ?? false,
    );
  }
}
