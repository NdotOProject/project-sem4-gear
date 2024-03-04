import 'package:gear_ui/src/local_storage/objects/cached_user.dart';

class SignedInUser {
  int id;
  String name;
  String email;
  String? avatar;
  bool employee;

  SignedInUser({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.employee = false,
  });

  factory SignedInUser.fromCached(CachedUser? cached) {
    return SignedInUser(
      id: cached?.id ?? 0,
      name: cached?.name ?? "",
      email: cached?.email ?? "",
    );
  }
}
