import 'package:gear_ui/src/features/auth/domain/user.dart';

class AuthRepository {
  AuthRepository();

  User? _user;

  void register({
    required String email,
    required String password,
  }) {}

  User signIn({
    required String email,
    required String password,
    bool remember = false,
  }) {
    // TODO: read database. if hasn't data => call api => set to _user.
    if (remember) {
      // TODO: save to database.
    } else {
      // TODO: if exist in database => remove.
    }
    return _user!;
  }

  bool get isSignedIn => _user != null;

  User? get user => _user;
}
