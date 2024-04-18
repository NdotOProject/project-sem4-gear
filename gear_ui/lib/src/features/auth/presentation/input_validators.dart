import 'package:email_validator/email_validator.dart';

class InputValidators {
  InputValidators._();

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required.";
    } else if (!EmailValidator.validate(value)) {
      return "Incorrect email format.";
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required.";
    } else if (value.length < 6) {
      return "Password length must greater than or equals to 6.";
    } else if (!RegExp(r'[a-z].*').hasMatch(value)) {
      return "Password must contains lowercase characters.";
    } else if (!RegExp(r'[A-Z].*').hasMatch(value)) {
      return "Password must contains uppercase characters.";
    } else if (!RegExp(r'[0-9].*').hasMatch(value)) {
      return "Password must contains numeric characters.";
    }
    return null;
  }
}
