import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/models/doctor_model.dart';
import '../../../data/repositories/reveiw_repository.dart';
import '../../../data/services/StorageService.dart';

class ReviewController extends GetxController {
  final ReviewRepository _repository;
  final StorageService _storage;

  ReviewController({
    ReviewRepository? repository,
    StorageService? storage,
  })  : _repository = repository ?? ReviewRepository(),
        _storage = storage ?? StorageService();

  final Rx<DoctorModel?> doctor = Rx<DoctorModel?>(null);
  final RxInt appointmentId = 0.obs;
  final RxInt doctorId = 0.obs;
  final RxDouble rating = 0.0.obs;
  final RxString reviewText = ''.obs;
  final RxBool wouldRecommend = true.obs;
  final RxBool isSubmitting = false.obs;

  final reviewTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    // if (args != null) {
    //   doctor.value = args['doctor'];
    //   appointmentId.value = args['appointmentId'] ?? 0;
    // }
    if (args['doctorId'] != null) {
      doctorId.value = args['doctorId'] ?? 0;
      appointmentId.value = args['appointmentId'] ?? 0;

      print('🟢 Loaded doctor: ${doctorId.value}, Appointment ID: ${appointmentId.value}');
    }
  }

  @override
  void onClose() {
    reviewTextController.dispose();
    super.onClose();
  }

  void setRating(double value) {
    rating.value = value;
  }

  void setRecommendation(bool value) {
    wouldRecommend.value = value;
  }

  Future<void> submitReview() async {
    // print("ertduyiojkpl ${doctor.value!.userId} ${appointmentId.value} ${rating.value} ${reviewTextController.text.trim()}");

    if (rating.value == 0) {
      Get.snackbar(
        'Error',
        'Please select a rating',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.orange,
        colorText: AppColors.white,
      );
      return;
    }

    if (reviewTextController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please write a review',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.orange,
        colorText: AppColors.white,
      );
      return;
    }

    try {
      isSubmitting.value = true;

      final token = await _storage.getToken();
      if (token == null) {
        Get.snackbar('Error', 'Please login first');
        Get.offAllNamed('/login');
        return;
      }
      // print("token $token ${doctor.value!.userId} ${appointmentId.value} ${rating.value} ${reviewTextController.text.trim()}");


      await _repository.addReview(
        token: token,
        doctorId: doctorId.value,
        appointmentId: appointmentId.value,
        rating: rating.value,
        reviewText: reviewTextController.text.trim(),
      );

      Get.snackbar(
        'Success',
        'Review submitted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.green,
        colorText: AppColors.white,
      );

      // Go back after a short delay
      Future.delayed(const Duration(seconds: 1), () {
        Get.back(result: true); // Return true to indicate success
      });
    } catch (e) {
      print('🔴 Error submitting review: $e');
      Get.snackbar(
        'Error',
        'Failed to submit review',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  void cancel() {
    Get.back();
  }
}
