import 'package:hive/hive.dart';

part 'cached_user.g.dart';

@HiveType(typeId: CachedUser.typeId)
class CachedUser extends HiveObject {
  static const int typeId = 5;

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
}
