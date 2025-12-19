// import 'package:get/get.dart';
// import '../../../data/models/category_model.dart';
//
// class CategoriesController extends GetxController {
//   final RxList<Specialization> categories = <Specialization>[].obs;
//   final RxBool isLoading = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadCategories();
//   }
//
//   void loadCategories() {
//     isLoading.value = true;
//
//     // Mock data - Replace with API call
//     // categories.value = [
    //   CategoryModel(id: '1', name: 'General', icon: 'general'),
    //   CategoryModel(id: '2', name: 'Cardiologist', icon: 'cardiologist'),
    //   CategoryModel(id: '3', name: 'Dentist', icon: 'dentist'),
    //   CategoryModel(id: '4', name: 'Dermatologist', icon: 'dermatologist'),
    //   CategoryModel(id: '5', name: 'Pediatrician', icon: 'pediatrician'),
    //   CategoryModel(id: '6', name: 'Gynecologist', icon: 'gynecologist'),
    //   CategoryModel(id: '7', name: 'Nutritionist', icon: 'nutritionist'),
    //   CategoryModel(id: '8', name: 'Endocrinologist', icon: 'endocrinologist'),
    //   CategoryModel(id: '9', name: 'Psychiatrist', icon: 'psychiatrist'),
    //   CategoryModel(id: '10', name: 'Hematologist', icon: 'hematologist'),
    //   CategoryModel(id: '11', name: 'Ophthalmologist', icon: 'ophthalmologist'),
    //   CategoryModel(id: '12', name: 'Oncologist', icon: 'oncologist'),
    //   CategoryModel(id: '13', name: 'Orthopedic', icon: 'orthopedic'),
    //   CategoryModel(id: '14', name: 'Urologist', icon: 'urologist'),
    //   CategoryModel(id: '15', name: 'Neurologist', icon: 'neurologist'),
    // ];
//
//     isLoading.value = false;
//   }
//
//   void onCategoryTap(Specialization category) {
//     Get.toNamed('/top-doctors', arguments: {'category': category.specializationName});
//   }
// }

// lib/modules/doctors/controllers/doctors_by_specialization_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/data/models/doctor_model.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/models/category_model.dart';
import '../../../data/repositories/doctor_repository.dart';
import '../../../data/services/StorageService.dart';

class DoctorsBySpecializationController extends GetxController {
  final DoctorsRepository _doctorsRepository;
  final StorageService _storage;

  DoctorsBySpecializationController({
    DoctorsRepository? doctorsRepository,
    StorageService? storage,
  })  : _doctorsRepository = doctorsRepository ?? DoctorsRepository(),
        _storage = storage ?? StorageService();

  final Rx<Specialization?> specialization = Rx<Specialization?>(null);
  final RxList<DoctorModel> doctors = <DoctorModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxSet<int> favoriteDoctorIds = <int>{}.obs;

  // Pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final hasNext = false.obs;
  final hasPrevious = false.obs;
  final totalCount = 0.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args != null && args['specialization'] != null) {
      specialization.value = args['specialization'] as Specialization;
      loadDoctors();
    }
  }

  Future<void> loadDoctors({int page = 1, int pageSize = 10}) async {
    try {
      isLoading.value = true;

      final token = await _storage.getToken();

      if (token == null) {
        Get.snackbar('Error', 'Please login first');
        Get.offAllNamed('/login');
        return;
      }

      final spec = specialization.value;
      if (spec == null) return;

      print('🔵 Controller: Fetching doctors for ${spec.specializationName}...');

      final response = await _doctorsRepository.getDoctors(
        token: token,
        specialization: spec.shortName, // Use short name (e.g., "th" for Therapist)
        pageNumber: page,
        pageSize: pageSize,
      );

      doctors.value = response.items;
      currentPage.value = response.pageNumber;
      totalPages.value = response.totalPages;
      hasNext.value = response.hasNext;
      hasPrevious.value = response.hasPrevious;
      totalCount.value = response.totalCount;

      print('🟢 Controller: Fetched ${response.items.length} doctors');

    } catch (e) {
      print('🔴 Controller: Error - $e');
      Get.snackbar('Error', 'Failed to load doctors');
    } finally {
      isLoading.value = false;
    }
  }

  bool isFavorite(int doctorId) {
    return favoriteDoctorIds.contains(doctorId);
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
            backgroundColor: AppColors.green,
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
        throw e;
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

  void onDoctorTap(DoctorModel doctor) {
    Get.toNamed('/doctor-detail', arguments: {'doctor': doctor});
  }

  void nextPage() {
    if (hasNext.value) {
      loadDoctors(page: currentPage.value + 1);
    }
  }

  void previousPage() {
    if (hasPrevious.value) {
      loadDoctors(page: currentPage.value - 1);
    }
  }

  Future<void> refresh() async {
    await loadDoctors(page: 1);
  }
}