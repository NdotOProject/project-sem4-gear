import 'package:hive/hive.dart';

part 'cached_user.g.dart';

@HiveType(typeId: CachedUser.typeId)
class CachedUser extends HiveObject {
  static const int typeId = 5;
  static const String boxName = "users";

  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String email;

  @HiveField(3)
  String password;

  @HiveField(4)
  String? avatar;

  @HiveField(5)
  bool employee;

  @HiveField(6)
  bool remember;

  CachedUser({
    this.id,
    this.name,
    this.email = "",
    this.password = "",
    this.avatar,
    this.employee = false,
    this.remember = false,
  });

  // json from api
  factory CachedUser.fromJson(Map<String, dynamic> json) {
    return CachedUser(
      id: json["id"] as int?,
      name: json["name"] as String?,
      avatar: json["avatar"] as String?,
      employee: json["employee"] as bool,
    );
  }

  @override
  String toString() {
    return 'CachedUser{id: $id, name: $name, email: $email, password: $password, avatar: $avatar, employee: $employee, remember: $remember}';
  }
}
