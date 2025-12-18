class User {
  final String? token;
  final int? userId;
  final String fullName;
  final String message;
  final String email;
  final String? role;

  User({
    this.token,
    this.userId,
    required this.fullName,
    required this.message,
    required this.email,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'],
      userId: json['userId'],
      fullName: json['fullName'] ?? '',
      message: json['message'] ?? '',
      email: json['email'] ?? '',
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token':token,
      'userId': userId,
      'fullName': fullName,
      'message': message,
      'email': email,
      'role': role,
    };
  }
}
