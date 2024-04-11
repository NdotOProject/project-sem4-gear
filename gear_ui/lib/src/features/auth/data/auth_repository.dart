import 'package:dio/dio.dart';
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
    /*
      {
        "success": true | false,
        "data": {
          "id": 1,
          "name": "Test",
          "avatar": null | string,
          "employee": true | false
        },
        "errors": {
          "email": [
            "abc",
            "xyz"
          ],
          "password": [
            "def",
            "ghi"
          ]
        }
      }
     */

    bool validate() {
      return user.email == "test@gmail.com" && user.password == "Test123";
    }

    final result = SignInResult.fromResponse(
      Response<String>(
        requestOptions: RequestOptions(),
        extra: <String, dynamic>{
          "success": validate(),
          if (!validate())
            "errors": {
              "email": ["Incorrect email."],
              "password": ["Incorrect password."],
            }
        },
        data: validate()
            ? """{
                "id": 1,
                "name": "Test",
                "avatar": null,
                "employee": false
              }"""
            : null,
      ),
    );

    final resultUser = result.user;

    resultUser?.remember = user.remember;
    resultUser?.email = user.remember ? user.email : "";
    resultUser?.password = user.remember ? user.password : "";

    if (resultUser != null && resultUser.remember) {
      _userBox.put(_key, resultUser);
    }

    return result;
  }
}
