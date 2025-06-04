class User {
  User({required this.id, required this.email, required this.fullName, required this.token, required this.roles});

  final String id;
  final String email;
  final String fullName;
  final List<String> roles;
  final String token;

  bool get isAdmin => roles.contains('admin');
}
