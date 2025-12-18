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
// }

// lib/modules/doctors/controllers/doctor_detail_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/doctor_model.dart';
import '../../../data/repositories/doctor_repository.dart';
import '../../../data/services/StorageService.dart';

class DoctorDetailController extends GetxController {
  final DoctorsRepository _doctorsRepository;
  final StorageService _storage;

  DoctorDetailController({
    DoctorsRepository? doctorsRepository,
    StorageService? storage,
  })  : _doctorsRepository = doctorsRepository ?? DoctorsRepository(),
        _storage = storage ?? StorageService();

  final Rx<DoctorModel?> doctor = Rx<DoctorModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isFavorite = false.obs;

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
      print('🟢 Controller: Doctor details loaded successfully');

    } catch (e) {
      print('🔴 Controller: Error - $e');
      Get.snackbar(
        'Error',
        'Failed to load doctor details',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    // Save to local storage
  }

  void onBookAppointment() {
    if (doctor.value != null) {
      Get.toNamed('/book-appointment', arguments: {
        'doctor': doctor.value,
      });
    }
  }

  void refresh() {
    loadDoctorDetails();
  }
}
