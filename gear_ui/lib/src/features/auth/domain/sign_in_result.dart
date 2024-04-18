import 'package:gear_ui/src/features/auth/domain/signed_in_user.dart';

class SignInResult {
  final SignedInUser? user;
  final String? emailError;
  final String? passwordError;
  final bool success;

  SignInResult.unknown()
      : user = null,
        emailError = null,
        passwordError = null,
        success = false;

  SignInResult.success(
    this.user,
  )   : emailError = null,
        passwordError = null,
        success = true;

  SignInResult.failed({
    this.passwordError,
    this.emailError,
  })  : user = null,
        success = false;
}

// factory SignInResult.fromResponse(Response<String> resp) {
//   if (resp.extra["success"] as bool) {
//     return SignInResult(
//       user: SignedInUser.fromCached(
//         CachedUser.fromJson(
//           json.decode(resp.data ?? "{}"),
//         ),
//       ),
//     );
//   } else {
//     final errors = resp.extra["errors"] as Map<String, String>;
//
//     return SignInResult(
//       emailErrors: errors["email"],
//       passwordErrors: errors["password"],
//     );
//   }
// }
