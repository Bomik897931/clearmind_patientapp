// class DoctorModel {
//   final String id;
//   final String name;
//   final String specialty;
//   final String hospital;
//   final String image;
//   final double rating;
//   final int reviewCount;
//   final int experience;
//   final String about;
//   final String workingTime;
//   final bool isFavorite;
//
//   DoctorModel({
//     required this.id,
//     required this.name,
//     required this.specialty,
//     required this.hospital,
//     required this.image,
//     required this.rating,
//     required this.reviewCount,
//     required this.experience,
//     this.about = '',
//     this.workingTime = 'Monday - Friday, 08:00 AM - 07:00 PM',
//     this.isFavorite = false,
//   });
//
//   factory DoctorModel.fromJson(Map<String, dynamic> json) {
//     return DoctorModel(
//       id: json['id'] ?? '',
//       name: json['name'] ?? '',
//       specialty: json['specialty'] ?? '',
//       hospital: json['hospital'] ?? '',
//       image: json['image'] ?? '',
//       rating: (json['rating'] ?? 0).toDouble(),
//       reviewCount: json['reviewCount'] ?? 0,
//       experience: json['experience'] ?? 0,
//       about: json['about'] ?? '',
//       workingTime: json['workingTime'] ?? '',
//       isFavorite: json['isFavorite'] ?? false,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'specialty': specialty,
//       'hospital': hospital,
//       'image': image,
//       'rating': rating,
//       'reviewCount': reviewCount,
//       'experience': experience,
//       'about': about,
//       'workingTime': workingTime,
//       'isFavorite': isFavorite,
//     };
//   }
//
//   DoctorModel copyWith({
//     String? id,
//     String? name,
//     String? specialty,
//     String? hospital,
//     String? image,
//     double? rating,
//     int? reviewCount,
//     int? experience,
//     String? about,
//     String? workingTime,
//     bool? isFavorite,
//   }) {
//     return DoctorModel(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       specialty: specialty ?? this.specialty,
//       hospital: hospital ?? this.hospital,
//       image: image ?? this.image,
//       rating: rating ?? this.rating,
//       reviewCount: reviewCount ?? this.reviewCount,
//       experience: experience ?? this.experience,
//       about: about ?? this.about,
//       workingTime: workingTime ?? this.workingTime,
//       isFavorite: isFavorite ?? this.isFavorite,
//     );
//   }
// }

import 'package:get/get.dart';

class DoctorModel {
  final int userId;
  final String firstName;
  final String lastName;
  final String gender;
  final String education;
  final String email;
  final String phoneNumber;
  final String address;
  final String dob;
  final int age;
  final int experienceYears;
  final double fees;
  final String about;
  final String role;
  final bool isActive;
  final bool isPsychiatrist;
  final bool isPsychologist;
  final bool isTherapist;
  final String rating;
  final int reviews;
  final int patients;
  final String wokingTime;
  final String wokingHospital;
  final String imageUrl;
  final String? specialization;
  final RxBool isFavorite;

  DoctorModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.education,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.dob,
    required this.age,
    required this.experienceYears,
    required this.fees,
    required this.about,
    required this.role,
    required this.isActive,
    required this.isPsychiatrist,
    required this.isPsychologist,
    required this.isTherapist,
    required this.rating,
    required this.reviews,
    required this.patients,
    required this.wokingTime,
    required this.wokingHospital,
    required this.imageUrl,
    this.specialization,
    bool isFavorite = false,
  }) : isFavorite = RxBool(isFavorite);

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      userId: json['userId'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      gender: json['gender'] ?? '',
      education: json['education'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      dob: json['dob'] ?? '',
      age: json['age'] ?? 0,
      experienceYears: json['experienceYears'] ?? 0,
      fees: json['fees'] != null ? (json['fees'] as num).toDouble() : 0.0,
      about: json['about'] ?? '',
      role: json['role'] ?? 'Doctor',
      isActive: json['isActive'] ?? true,
      isPsychiatrist: json['isPsychiatrist'] ?? false,
      isPsychologist: json['isPsychologist'] ?? false,
      isTherapist: json['isTherapist'] ?? false,
      rating: json['rating']?.toString() ?? '0.0',  // Convert to string safely
      reviews: json['reviews'] ?? 0,
      patients: json['patients'] ?? 0,
      wokingTime: json['wokingTime'] ?? '',
      wokingHospital: json['wokingHospital'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      specialization: json['specialization'], // Already nullable, so this is fine
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  String get fullName => '$firstName $lastName';

  String get specialty {
    List<String> specialties = [];
    if (isPsychiatrist) specialties.add('Psychiatrist');
    if (isPsychologist) specialties.add('Psychologist');
    if (isTherapist) specialties.add('Therapist');
    return specialties.isEmpty ? education : specialties.join(', ');
  }
}