import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/data/repositories/user_repository.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/models/profile_model.dart';
import '../../../data/services/StorageService.dart';

class EditProfileController extends GetxController {
  final fullNameController = TextEditingController(text: 'Ellison Perry');
  final emailController = TextEditingController(
    text: 'andrew_ainsley@gmail.com',
  );
  final phoneController = TextEditingController(text: '+91 9568256880');

  final RxString selectedGender = 'Female'.obs;
  final RxInt selectedAge = 25.obs;
  final isLoading = false.obs;
  final StorageService _storage =  StorageService();
  final  AuthRepository _authRepository = AuthRepository();

  final Rx<UserProfile?> currentUser = Rx<UserProfile?>(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfile();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  // void onUpdate() {
  //   Get.snackbar(
  //     'Success',
  //     'Profile updated successfully',
  //     snackPosition: SnackPosition.BOTTOM,
  //   );
  //   Get.back();
  // }

  void onUpdate() async {
    try {
      isLoading(true);
      final token = await _storage.getToken();
      if (token == null) {
        _showError('Please login first');
        Get.offAllNamed('/login');
        return;
      }

      final data = {
        "firstName": fullNameController.text,
        "lastName": currentUser.value!.lastName,
        "email": emailController.text,
        "phoneNumber": phoneController.text,
        "gender": selectedGender.value.toLowerCase(),
        "bloodGroup": currentUser.value!.bloodGroup,
        "emergencyContact": currentUser.value!.emergencyContact,
        "insuranceDetails": currentUser.value!.insuranceDetails,
        "isActive": true,
        "street": "Gachibowli",
        "city": "Hyderabad",
        "state": "Telangana",
        "country": "India",
        "zipCode": "500032",
      };

      final success = await _authRepository.updateMyProfile(
        currentUser.value!.userId!,
        data,
        token!
      );
      isLoading.value = false;

      if (success) {
        Get.defaultDialog(
          title: "Success",
          middleText: "Profile updated successfully!",
          textConfirm: "OK",
          onConfirm: () {
            Get.back(); // close dialog
            Get.toNamed('/home');
            // Get.back(); // go back
          },
        );
      }

    // }
    } on RepositoryException catch (e) {
      print('🔴 Controller: RepositoryException - ${e.message}');
      _showError(e.message);
      isLoading.value = false;
    } catch (e) {
      print('🔴 Controller: Unexpected error - $e');
      _showError('Failed to load profile');
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }



  Future<void> getProfile() async {
    try {
      isLoading.value = true;

      final token = await _storage.getToken();

      if (token == null) {
        _showError('Please login first');
        Get.offAllNamed('/login');
        return;
      }

      print('🔵 Controller: Fetching profile...');

      final user = await _authRepository.getProfile(token);

      print('🟢 Controller: Profile fetched successfully');

      currentUser.value = user;
      // ✨ Populate form fields with user data
      fullNameController.text = user.firstName;
      emailController.text = user.email ?? '';
      phoneController.text = user.phoneNumber ?? '';

      final gender = user.gender?.toLowerCase().trim();

      if (gender == 'male') {
        selectedGender.value = 'Male';
      } else if (gender == 'female') {
        selectedGender.value = 'Female';
      } else {
        selectedGender.value = 'Other';
      }
      // selectedAge.value = user.age ?? 0;  // age optional
      // await _storage.saveUser(user);

      _showSuccess('Profile loaded successfully');
    } on RepositoryException catch (e) {
      print('🔴 Controller: RepositoryException - ${e.message}');
      _showError(e.message);
    } catch (e) {
      print('🔴 Controller: Unexpected error - $e');
      _showError('Failed to load profile');
    } finally {
      isLoading.value = false;
    }
  }
  void _showSuccess(String message) {
    Get.snackbar(
      'Success',
      message.isEmpty ? 'Registration successful!' : message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.green,
      colorText: AppColors.white,
      duration: const Duration(seconds: 3),
    );
  }
  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.red,
      colorText: AppColors.white,
      duration: const Duration(seconds: 3),
    );
  }
}
