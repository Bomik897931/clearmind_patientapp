import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/locale_controller.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/StorageService.dart';

class ProfileController extends GetxController {
  final RxBool notificationEnabled = true.obs;
  final RxBool languagebool = true.obs;
  final RxInt selectedBottomIndex = 3.obs;
  final isLoading = false.obs;
  final isLoggedIn = false.obs;

  final StorageService _storage =  StorageService();

  final Rx<User?> currentUser = Rx<User?>(null);

  final localeController = Get.find<LocaleController>();

  void toggleNotification(bool value) {
    notificationEnabled.value = value;
  }

  void toggleLanguage(bool value){
    if(value == true){
      localeController.changeLocale(const Locale('en'));
      notificationEnabled.value = value;
    }else{
      localeController.changeLocale(const Locale('hi'));
      notificationEnabled.value = value;
    }
  }

  void onEditProfile() {
    Get.toNamed('/edit-profile');
  }

  void onChangePassword() {
    // Navigate to change password screen
  }

  void onFAQs() {
    Get.toNamed('/faqs');
  }

  void onHelp() {
    Get.toNamed('/help');
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;

      print('🔵 Controller: Logging out...');

      // Clear storage - THIS IS MISSING
      await _storage.clearUser();

      // Reset state
      currentUser.value = null;
      isLoggedIn.value = true;

      print('✅ Controller: Storage cleared, navigating to login');

      // Navigate to login
      Get.offAllNamed('/login');

      // Show success message
      Get.snackbar(
        'Success',
        'Logged out successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('🔴 Controller: Logout error - $e');
      Get.snackbar(
        'Error',
        'Failed to logout',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onLogout() {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              Get.offAllNamed('/home');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
