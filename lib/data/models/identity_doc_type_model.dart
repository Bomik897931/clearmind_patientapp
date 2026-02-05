class IdentityDocType {
  final int id;
  final String name;

  IdentityDocType({
    required this.id,
    required this.name,
  });

  factory IdentityDocType.fromJson(Map<String, dynamic> json) {
    return IdentityDocType(
      id: json['id'],
      name: json['name'],
    );
  }
}
