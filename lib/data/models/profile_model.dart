class UserProfile {
  final int? userId;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final String? gender;
  final String? address;
  final bool? isActive;
  final String? patientCode;
  final String? bloodGroup;
  final String? emergencyContact;
  final String? insuranceDetails;
  final String? profilePicUrl;
  final String? role;
  final String? token;
  final String? fullName;

  UserProfile({
    this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    this.gender,
    this.address,
    this.isActive,
    this.patientCode,
    this.bloodGroup,
    this.emergencyContact,
    this.insuranceDetails,
    this.profilePicUrl,
    this.role,
    this.token,
    this.fullName,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['userId'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
      address: json['address'],
      isActive: json['isActive'],
      patientCode: json['patientCode'],
      bloodGroup: json['bloodGroup'],
      emergencyContact: json['emergencyContact'],
      insuranceDetails: json['insuranceDetails'],
      profilePicUrl: json['profilePicUrl'],
      role: json['role'],
      token: json['token'],
      fullName: json['fullName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'address': address,
      'isActive': isActive,
      'patientCode': patientCode,
      'bloodGroup': bloodGroup,
      'emergencyContact': emergencyContact,
      'insuranceDetails': insuranceDetails,
      'profilePicUrl': profilePicUrl,
      'role': role,
      'token': token,
      'fullName': fullName,
    };
  }
}