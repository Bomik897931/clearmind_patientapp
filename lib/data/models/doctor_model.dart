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

  /// ✅ FIXED
  final List<String> specialization;
  final List<String> languages;

  final List<ConsultingFee> consultingFees;
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
    required this.specialization,
    required this.languages,
    required this.consultingFees,
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
      fees: (json['fees'] as num?)?.toDouble() ?? 0.0,
      about: json['about'] ?? '',
      role: json['role'] ?? 'Doctor',
      isActive: json['isActive'] ?? true,
      isPsychiatrist: json['isPsychiatrist'] ?? false,
      isPsychologist: json['isPsychologist'] ?? false,
      isTherapist: json['isTherapist'] ?? false,
      rating: json['rating']?.toString() ?? '0',
      reviews: json['reviews'] ?? 0,
      patients: json['patients'] ?? 0,
      wokingTime: json['wokingTime'] ?? '',
      wokingHospital: json['wokingHospital'] ?? '',
      imageUrl: json['imageUrl'] ?? '',

      /// ✅ FIXED HERE
      specialization: (json['specialization'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          [],

      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          [],

      consultingFees: (json['consultingFees'] as List<dynamic>?)
          ?.map(
            (e) =>
            ConsultingFee.fromJson(e as Map<String, dynamic>),
      )
          .toList() ??
          [],

      isFavorite: json['isFavorite'] ?? false,
    );
  }

  /// Computed properties
  String get fullName => '$firstName $lastName';

  String get specialty {
    List<String> specialties = [];

    if (isPsychiatrist) specialties.add('Psychiatrist');
    if (isPsychologist) specialties.add('Psychologist');
    if (isTherapist) specialties.add('Therapist');

    if (specialties.isNotEmpty) {
      return specialties.join(', ');
    }

    return specialization.isNotEmpty
        ? specialization.join(', ')
        : education;
  }
}



class ConsultingFee {
  final int durationInMinutes;
  final double fee;

  ConsultingFee({
    required this.durationInMinutes,
    required this.fee,
  });

  factory ConsultingFee.fromJson(Map<String, dynamic> json) {
    return ConsultingFee(
      durationInMinutes: json['durationInMinutes'] ?? 0,
      fee: json['fee'] != null
          ? (json['fee'] as num).toDouble()
          : 0.0,
    );
  }
}
