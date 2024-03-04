import 'package:gear_ui/src/features/auth/domain/sign_in_result.dart';
import 'package:gear_ui/src/features/auth/domain/sign_in_user.dart';
import 'package:gear_ui/src/features/auth/domain/signed_in_user.dart';
import 'package:gear_ui/src/local_storage/objects/cached_user.dart';
import 'package:gear_ui/src/local_storage/utils/cached_objects.dart';
import 'package:hive/hive.dart';

class AuthRepository {
  static const String _key = "user";

  final Box<CachedUser> _userBox;

  AuthRepository._(this._userBox);

  static Future<AuthRepository> get instance async {
    return AuthRepository._(await CachedObjects.user);
  }

  CachedUser? get _cached => _userBox.get(_key);

  SignedInUser? get user => SignedInUser.fromCached(_cached);

  bool get isSignedIn => user != null;

  SignInUser get rememberedUser => SignInUser.fromCached(_cached);

  void register({
    required String email,
    required String password,
  }) {}

  Future<SignInResult> signIn(SignInUser user) async {
    // TODO: call api.
    final response = CachedUser(
      id: 1,
      name: "Test",
      // email: "test@gmail.com",
      // password: "123456",
      avatar: null,
      employee: false,
    );
    response.remember = user.remember;
    response.email = user.remember ? user.email : "";
    response.password = user.remember ? user.password : "";

    return SignInResult();
  }
}
