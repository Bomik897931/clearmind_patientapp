class AddressModel {
  final int? addressId;
  final String street;
  final String city;
  final String state;
  final String country;
  final String zipCode;
  final bool isPrimary;

  AddressModel({
    this.addressId,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.isPrimary,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addressId: json['addressId'],
      street: json['street'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      zipCode: json['zipCode'],
      isPrimary: json['isPrimary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (addressId != null) 'addressId': addressId,
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
      'isPrimary': isPrimary,
    };
  }
}
