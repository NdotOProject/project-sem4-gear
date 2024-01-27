class User {
  int id;
  String name;
  String email;
  String password;
  String avatar;
  bool employee;
  bool status;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.employee,
    required this.password,
    required this.status,
  });
}
