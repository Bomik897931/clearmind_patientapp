import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/doctor_model.dart';
import '../../../data/models/review_model.dart';
import '../../../data/repositories/reveiw_repository.dart';
import '../../../data/services/StorageService.dart';

class ReviewsListController extends GetxController {
  final ReviewRepository _repository;
  final StorageService _storage;

  ReviewsListController({
    ReviewRepository? repository,
    StorageService? storage,
  })  : _repository = repository ?? ReviewRepository(),
        _storage = storage ?? StorageService();

  final Rx<DoctorModel?> doctor = Rx<DoctorModel?>(null);
  final RxList<ReviewModel> reviews = <ReviewModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedFilter = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['doctor'] != null) {
      doctor.value = args['doctor'];
      loadReviews();
    }
  }

  Future<void> loadReviews() async {
    if (doctor.value == null) return;

    try {
      isLoading.value = true;

      final token = await _storage.getToken();
      if (token == null) {
        Get.snackbar('Error', 'Please login first');
        Get.offAllNamed('/login');
        return;
      }

      final fetchedReviews = await _repository.getReviews(
        token: token,
        // doctorId: 15
        doctorId: doctor.value!.userId,
      );

      reviews.value = fetchedReviews;
      print('🟢 Loaded ${fetchedReviews.length} reviews');
    } catch (e) {
      print('🔴 Error loading reviews: $e');
      Get.snackbar(
        'Error',
        'Failed to load reviews',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  List<ReviewModel> get filteredReviews {
    if (selectedFilter.value == 'All') {
      return reviews;
    }
    final filterRating = int.parse(selectedFilter.value);
    return reviews.where((r) => r.rating.round() == filterRating).toList();
  }

  String get averageRating {
    if (reviews.isEmpty) return '0.0';
    final avg = reviews.map((r) => r.rating).reduce((a, b) => a + b) / reviews.length;
    return avg.toStringAsFixed(1);
  }
}

// ==================== REVIEWS LIST SCREEN ====================

// reviews_list_screen.dart
