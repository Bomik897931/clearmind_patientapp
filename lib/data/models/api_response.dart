class ApiResponse<T> {
  final bool success;
  final String? message;
  final T? data;
  final dynamic errors;

  ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.errors,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'],
      errors: json['errors'],
    );
  }
}