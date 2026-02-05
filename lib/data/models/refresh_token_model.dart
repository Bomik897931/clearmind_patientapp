class RefreshTokenModel {
  bool? isValid;
  int? userId;
  String? role;
  Null message;

  RefreshTokenModel({this.isValid, this.userId, this.role, this.message});

  RefreshTokenModel.fromJson(Map<String, dynamic> json) {
    isValid = json['isValid'];
    userId = json['userId'];
    role = json['role'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isValid'] = isValid;
    data['userId'] = userId;
    data['role'] = role;
    data['message'] = message;
    return data;
  }
}
