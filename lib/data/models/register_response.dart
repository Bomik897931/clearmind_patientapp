class RegisterResponse {
  final bool success;
  final String message;
  final String? userId;
  final String? role;

  RegisterResponse({
    required this.success,
    required this.message,
    this.userId,
    this.role,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      userId: json['userId'],
      role: json['role'],
    );
  }
}