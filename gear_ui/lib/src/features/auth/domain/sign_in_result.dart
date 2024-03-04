class SignInResult {
  SignInResult({
    this.emailErrors,
    this.passwordErrors,
  });

  final List<String>? emailErrors;
  final List<String>? passwordErrors;

  bool get success {
    return (emailErrors?.isEmpty ?? true) && (passwordErrors?.isEmpty ?? true);
  }
}
