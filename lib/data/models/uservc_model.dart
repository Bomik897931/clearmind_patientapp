class UserVCModel {
  final String id;
  final String email;
  final String name;
  final String? phone;
  final String? avatar;
  final String? token;

  UserVCModel({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.avatar,
    this.token,
  });

  factory UserVCModel.fromJson(Map<String, dynamic> json) {
    return UserVCModel(
      id: json['id']?.toString() ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'],
      avatar: json['avatar'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'avatar': avatar,
      'token': token,
    };
  }

  UserVCModel copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? avatar,
    String? token,
  }) {
    return UserVCModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      token: token ?? this.token,
    );
  }
}
