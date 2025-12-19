import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/models/favorite_model.dart';
import '../../../data/repositories/doctor_repository.dart';
import '../../../data/services/StorageService.dart';
import '../../../widgets/remove_fav_dialog.dart';

class FavoriteDoctorsController extends GetxController {
  final DoctorsRepository _repository;
  final StorageService _storage;

  FavoriteDoctorsController({
    DoctorsRepository? repository,
    StorageService? storage,
  })  : _repository = repository ?? DoctorsRepository(),
        _storage = storage ?? StorageService();

  final RxList<FavoriteDoctorModel> favoriteDoctors = <FavoriteDoctorModel>[].obs;
  final RxBool isLoading = false.obs;

  final RxInt selectedBottomIndex = 2.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavoriteDoctors();
  }

  Future<void> loadFavoriteDoctors() async {
    try {
      isLoading.value = true;

      final token = await _storage.getToken();
      if (token == null) {
        Get.snackbar('Error', 'Please login first');
        Get.offAllNamed('/login');
        return;
      }

      final doctors = await _repository.getFavoriteDoctors(token: token);
      favoriteDoctors.value = doctors;

      print('🟢 Loaded ${doctors.length} favorite doctors');
    } catch (e) {
      print('🔴 Error loading favorite doctors: $e');
      Get.snackbar(
        'Error',
        'Failed to load favorite doctors',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onDoctorTap(FavoriteDoctorModel doctor) {
    // Navigate to doctor detail if needed
    print('Tapped on: ${doctor.doctorName}');
  }

  void showRemoveDialog(FavoriteDoctorModel doctor) {
    Get.dialog(
      RemoveFavoriteDialog(
        doctor: doctor,
        onConfirm: () => removeFavorite(doctor),
      ),
      barrierDismissible: true,
    );
  }

  Future<void> removeFavorite(FavoriteDoctorModel doctor) async {
    try {
      Get.back(); // Close dialog

      final token = await _storage.getToken();
      if (token == null) return;

      // Optimistically remove from list
      favoriteDoctors.removeWhere((d) => d.doctorId == doctor.doctorId);

      final success = await _repository.removeFavorite(
        token: token,
        doctorId: doctor.doctorId,
      );

      if (success) {
        Get.snackbar(
          'Success',
          'Removed from favorites',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.green,
          colorText: AppColors.white,
          duration: const Duration(seconds: 2),
        );
      } else {
        // Revert if failed
        loadFavoriteDoctors();
      }
    } catch (e) {
      print('🔴 Error removing favorite: $e');
      // Reload list on error
      loadFavoriteDoctors();
      Get.snackbar(
        'Error',
        'Failed to remove from favorites',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    }
  }

  Future<void> refresh() async {
    await loadFavoriteDoctors();
  }
}