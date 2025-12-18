class RegisterRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String gender;
  final String password;
  final String bloodGroup;
  final String emergencyContact;
  final String insuranceDetails;
  final String? profilePicUrl;
  final String street;
  final String city;
  final String state;
  final String country;
  final String zipCode;
  final String dob;

  RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.password,
    required this.bloodGroup,
    required this.emergencyContact,
    required this.insuranceDetails,
    this.profilePicUrl,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.dob,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'password': password,
      'bloodGroup': bloodGroup,
      'emergencyContact': emergencyContact,
      'insuranceDetails': insuranceDetails,
      'profilePicUrl': profilePicUrl ?? 'string',
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
      'dob': dob,
    };
  }
}