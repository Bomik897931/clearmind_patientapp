// import 'package:get/get.dart';
// import '../../../data/models/doctor_model.dart';
// import '../../../data/models/review_model.dart';
//
// class DoctorDetailController extends GetxController {
//   final Rx<DoctorModel?> doctor = Rx<DoctorModel?>(null);
//   final RxList<ReviewModel> reviews = <ReviewModel>[].obs;
//   final RxBool isLoading = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     final args = Get.arguments;
//     if (args != null && args['doctor'] != null) {
//       doctor.value = args['doctor'];
//       loadReviews();
//     }
//   }
//
//   void loadReviews() {
//     isLoading.value = true;
//
//     // Mock data - Replace with API call
//     reviews.value = [
//       ReviewModel(
//         id: '1',
//         userName: 'Charolette Hanlin',
//         userImage: '',
//         rating: 5,
//         comment:
//             'Dr. Jenny is very professional in her work and responsive. I have consulted and my problem is solved. 😍😍',
//         date: DateTime.now().subtract(const Duration(days: 2)),
//       ),
//       ReviewModel(
//         id: '2',
//         userName: 'Charolette Hanlin',
//         userImage: '',
//         rating: 5,
//         comment:
//             'Dr. Jenny is very professional in her work and responsive. I have consulted and my problem is solved. 😍😍',
//         date: DateTime.now().subtract(const Duration(days: 5)),
//       ),
//       ReviewModel(
//         id: '3',
//         userName: 'Charolette Hanlin',
//         userImage: '',
//         rating: 5,
//         comment:
//             'Dr. Jenny is very professional in her work and responsive. I have consulted and my problem is solved. 😍😍',
//         date: DateTime.now().subtract(const Duration(days: 10)),
//       ),
//     ];
//
//     isLoading.value = false;
//   }
//
//   void onBookAppointment() {
//     Get.toNamed('/book-appointment', arguments: {'doctor': doctor.value});
//   }
//
//   void onWriteReview() {
//     Get.toNamed('/write-review', arguments: {'doctor': doctor.value});
//   }
//
//   // void toggleFavorite() {
//   //   if (doctor.value != null) {
//   //     doctor.value = doctor.value!.copyWith(
//   //       isFavorite: !doctor.value!.isFavorite,
//   //     );
//   //   }
//   // }
import 'package:flutter/material.dart';
// }

// lib/modules/doctors/controllers/doctor_detail_controller.dart
import 'package:get/get.dart';
import '../../../data/repositories/reveiw_repository.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/models/doctor_model.dart';
import '../../../data/models/review_model.dart';
import '../../../data/repositories/doctor_repository.dart';
import '../../../data/services/StorageService.dart';

class DoctorDetailController extends GetxController {
  final DoctorsRepository _doctorsRepository;
  final StorageService _storage;

  DoctorDetailController({
    DoctorsRepository? doctorsRepository,
    StorageService? storage,
  }) : _doctorsRepository = doctorsRepository ?? DoctorsRepository(),
       _storage = storage ?? StorageService();

  final Rx<DoctorModel?> doctor = Rx<DoctorModel?>(null);
  RxList<ReviewModel> reviews = <ReviewModel>[].obs;
  final ReviewRepository _repository = ReviewRepository();
  final RxBool isLoading = false.obs;
  final RxBool isFavorite = false.obs;
  final supportedLocales = const [
    Locale('en'),
    Locale('hi'),
  ];

  final _locale = const Locale('en').obs;
  Locale get locale => _locale.value;


  late int doctorId;

  @override
  void onInit() {
    super.onInit();

    // Get doctor from arguments
    final args = Get.arguments;
    if (args != null && args['doctor'] != null) {
      final passedDoctor = args['doctor'] as DoctorModel;
      doctorId = passedDoctor.userId;

      loadDoctorDetails();
    }
  }
  Future<void> changeLocale(Locale newLocale) async {
    print(newLocale);
    if (!supportedLocales.contains(newLocale)) return;

    _locale.value = newLocale;
    Get.updateLocale(newLocale);
    update();
  }

  Future<void> loadDoctorDetails() async {
    try {
      isLoading.value = true;

      final token = await _storage.getToken();

      if (token == null) {
        Get.snackbar('Error', 'Please login first');
        Get.offAllNamed('/login');
        return;
      }

      print('🔵 Controller: Fetching doctor details for ID: $doctorId');

      final response = await _doctorsRepository.getDoctorById(
        token: token,
        doctorId: doctorId,
      );

      doctor.value = response;
      print(doctor.value);
      fetchReview(doctor.value!.userId);
      print('🟢 Controller: Doctor details loaded successfully');
    } catch (e) {
      print('🔴 Controller: Error - $e');
      Get.snackbar(
        'Error',
        'Failed to load doctor details',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleFavorite(DoctorModel doctor) async {
    try {
      final token = await _storage.getToken();
      if (token == null) {
        Get.snackbar('Error', 'Please login first');
        return;
      }

      // Optimistically update UI (only the icon will update)
      final wasFavorite = doctor.isFavorite.value;
      doctor.isFavorite.value = !wasFavorite;

      try {
        final bool success;
        if (wasFavorite) {
          success = await _doctorsRepository.removeFavorite(
            token: token,
            doctorId: doctor.userId,
          );
        } else {
          success = await _doctorsRepository.addFavorite(
            token: token,
            doctorId: doctor.userId,
          );
        }

        if (success) {
          Get.snackbar(
            'Success',
            wasFavorite ? 'Removed from favorites' : 'Added to favorites',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.circularprogressindicator,
            colorText: AppColors.white,
            duration: const Duration(seconds: 1),
          );
        } else {
          // Revert on failure
          doctor.isFavorite.value = wasFavorite;
        }
      } catch (e) {
        // Revert on error
        doctor.isFavorite.value = wasFavorite;
        rethrow;
      }
    } catch (e) {
      print('🔴 Error toggling favorite: $e');
      Get.snackbar(
        'Error',
        'Failed to update favorite',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    }
  }

  void onBookAppointment() {
    if (doctor.value != null) {
      Get.toNamed('/book-appointment', arguments: {'doctor': doctor.value});
    }
  }

  @override
  void refresh() {
    loadDoctorDetails();
  }

  Future<void> fetchReview(int value) async {
    print(doctor.value);

    try {
      isLoading.value = true;

      final token = await _storage.getToken();
      if (token == null) {
        Get.snackbar('Error', 'Please login first');
        Get.offAllNamed('/login');
        return;
      }

      print('${doctor.value!.userId}');
      final fetchedReviews = await _repository.getReviews(
        token: token,
        // doctorId: 15
        doctorId: value,
      );

      reviews.value = fetchedReviews;
      print('🟢 Loaded ${fetchedReviews.length} reviews');
    } catch (e) {
      print('🔴 Error loading reviews: $e');
      Get.snackbar(
        'Error',
        'Failed to load reviews',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
