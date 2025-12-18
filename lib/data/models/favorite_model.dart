class FavoriteDoctorModel {
  final int favoriteDoctorId;
  final int doctorId;
  final String doctorName;
  final String rating;
  final int reviews;
  final bool isTherapist;
  final bool isPsychiatrist;
  final bool isPsychologist;
  final String imageUrl;

  FavoriteDoctorModel({
    required this.favoriteDoctorId,
    required this.doctorId,
    required this.doctorName,
    required this.rating,
    required this.reviews,
    required this.isTherapist,
    required this.isPsychiatrist,
    required this.isPsychologist,
    required this.imageUrl,
  });

  factory FavoriteDoctorModel.fromJson(Map<String, dynamic> json) {
    return FavoriteDoctorModel(
      favoriteDoctorId: json['favoriteDoctorId'] ?? 0,
      doctorId: json['doctorId'] ?? 0,
      doctorName: json['doctorName'] ?? '',
      rating: json['rating']?.toString() ?? '0.0',
      reviews: json['reviews'] ?? 0,
      isTherapist: json['isTherapist'] ?? false,
      isPsychiatrist: json['isPsychiatrist'] ?? false,
      isPsychologist: json['isPsychologist'] ?? false,
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  String get specialty {
    List<String> specialties = [];
    if (isPsychiatrist) specialties.add('Psychiatrist');
    if (isPsychologist) specialties.add('Psychologist');
    if (isTherapist) specialties.add('Therapist');
    return specialties.isEmpty ? 'Cardiologist' : specialties.join(', ');
  }

  String get formattedReviews {
    if (reviews >= 1000) {
      return '${(reviews / 1000).toStringAsFixed(1)}k';
    }
    return reviews.toString();
  }
}