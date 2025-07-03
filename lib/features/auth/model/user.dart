// File: frontend/lib/features/auth/model/user.dart

class User {
  final String id;
  final String email;
  final String mobile;
  final String name;

  User({
    required this.id,
    required this.email,
    required this.mobile,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
      name: json['name'] as String,
    );
  }
}
