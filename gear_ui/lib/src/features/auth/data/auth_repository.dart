import 'package:gear_ui/src/features/auth/domain/sign_in_result.dart';
import 'package:gear_ui/src/features/auth/domain/sign_in_request.dart';
import 'package:gear_ui/src/features/auth/domain/sign_up_request.dart';
import 'package:gear_ui/src/features/auth/domain/sign_up_result.dart';
import 'package:gear_ui/src/features/auth/domain/signed_in_user.dart';
import 'package:gear_ui/src/local_storage/obj/users/cached_user.dart';
import 'package:gear_ui/src/local_storage/utils/cached_objects.dart';
import 'package:hive/hive.dart';

class AuthRepository {
  static late final AuthRepository? _instance;

  AuthRepository._(this._userBox);

  static Future<AuthRepository> get instance async {
    _instance ??= AuthRepository._(await CachedObjects.user);
    return _instance!;
  }

  final Box<CachedUser> _userBox;

  Map<String, CachedUser> get _cached => {..._userBox.toMap()};

  SignedInUser? _signedInUser;

  SignedInUser? get user => _signedInUser;

  bool get isSignedIn => _signedInUser != null;

  SignUpResult register(SignUpRequest request) {
    var cachedUser = _cached[request.email];

    if (cachedUser != null) {
      return SignUpResult.failed(emailError: "Email exist.");
    }

    int nextId = 1;

    final users = [..._userBox.values];
    if (users.isNotEmpty) {
      if (users.length >= 2) {
        users.sort((cachedUser1, cachedUser2) {
          return cachedUser1.id!.compareTo(cachedUser2.id!);
        });
      }

      nextId = users.last.id! + 1;
    }

    final newUser = CachedUser(
      id: nextId,
      name: request.email,
      email: request.email,
      password: request.password,
    );

    _userBox.put(newUser.email, newUser);

    return SignUpResult.success(
      SignInRequest.fromCached(newUser),
    );
  }

  SignInResult signIn(SignInRequest request) {
    CachedUser? validate() {
      var matched = _cached[request.email];

      if (matched != null && matched.password == request.password) {
        return matched;
      } else {
        return null;
      }
    }

    CachedUser? validatedResult = validate();

    _signedInUser = SignedInUser.fromCached(validatedResult);

    return validatedResult != null
        ? SignInResult.success(user)
        : SignInResult.failed(
            emailError: "Incorrect email.",
            passwordError: "Incorrect password.",
          );
  }

  void signOut() {
    _signedInUser = null;
  }
}
