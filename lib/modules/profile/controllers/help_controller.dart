import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/core/constants/app_colors.dart';

class HelpController extends GetxController {
  final messageController = TextEditingController();

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void onSendMail() {
    if (messageController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please write your message',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
      );
      return;
    }

    Get.snackbar(
      'Success',
      'Your message has been sent successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.success,
      colorText: AppColors.white,
    );

    messageController.clear();
    Future.delayed(const Duration(seconds: 2), () => Get.back());
  }
}
