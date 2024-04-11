import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gear_ui/src/local_storage/objects/cached_user.dart';

class SignInResult {
  final CachedUser? user;
  final List<String>? emailErrors;
  final List<String>? passwordErrors;

  SignInResult({
    this.user,
    this.emailErrors,
    this.passwordErrors,
  });

  factory SignInResult.fromResponse(Response<String> resp) {
    if (resp.extra["success"] as bool) {
      return SignInResult(
        user: CachedUser.fromJson(json.decode(resp.data ?? "{}")),
      );
    } else {
      final errors = resp.extra["errors"] as Map<String, List<String>>;

      return SignInResult(
        emailErrors: errors["email"],
        passwordErrors: errors["password"],
      );
    }
  }

  bool get success {
    return (emailErrors?.isEmpty ?? true) && (passwordErrors?.isEmpty ?? true);
  }
}
