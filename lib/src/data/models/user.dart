class User {
  final String id, email, name, lastName, password;
  final DateTime birthday;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.lastName,
    required this.password,
    required this.birthday,
  }) : assert(email.contains("@"), "Invalid email");
}
