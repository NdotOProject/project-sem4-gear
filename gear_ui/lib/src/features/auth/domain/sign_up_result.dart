import 'package:gear_ui/src/features/auth/domain/sign_in_request.dart';

class SignUpResult {
  final SignInRequest? signInRequest;
  final String? emailError;
  final String? passwordError;
  final bool success;

  SignUpResult.unknown()
      : signInRequest = null,
        emailError = null,
        passwordError = null,
        success = false;

  SignUpResult.failed({
    this.emailError,
    this.passwordError,
  })  : signInRequest = null,
        success = false;

  SignUpResult.success(
    this.signInRequest,
  )   : emailError = null,
        passwordError = null,
        success = true;
}
