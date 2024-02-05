class User {
  int? id;
  String name;
  String email;
  String password;
  String avatar;
  bool employee;
  bool status;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.avatar,
    this.employee = false,
    this.status = true,
  });
}
