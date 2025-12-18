import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCardController extends GetxController {
  final cardNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvvController = TextEditingController();

  @override
  void onClose() {
    cardNameController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.onClose();
  }

  void onNext() {
    if (cardNameController.text.isEmpty ||
        cardNumberController.text.isEmpty ||
        expiryDateController.text.isEmpty ||
        cvvController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all card details',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Get.toNamed('/payment');
  }
}
