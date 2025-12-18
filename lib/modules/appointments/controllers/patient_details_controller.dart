import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/doctor_model.dart';

class PatientDetailsController extends GetxController {
  final Rx<DoctorModel?> doctor = Rx<DoctorModel?>(null);
  final Rx<DateTime?> appointmentDate = Rx<DateTime?>(null);
  final RxString appointmentTime = ''.obs;

  final fullNameController = TextEditingController();
  final weightController = TextEditingController();
  final symptomsController = TextEditingController();

  final RxString selectedGender = 'Male'.obs;
  final RxString selectedBlood = 'O Positive'.obs;
  final Rx<DateTime?> dateOfBirth = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      doctor.value = args['doctor'];
      appointmentDate.value = args['date'];
      appointmentTime.value = args['time'];
    }

    // Pre-fill with mock data
    fullNameController.text = 'Andrew Ainsley';
    selectedGender.value = 'Male';
    dateOfBirth.value = DateTime(1990, 1, 29);
    weightController.text = '49 kg';
    selectedBlood.value = 'O Positive';
  }

  @override
  void onClose() {
    fullNameController.dispose();
    weightController.dispose();
    symptomsController.dispose();
    super.onClose();
  }

  void onNext() {
    if (fullNameController.text.isEmpty || symptomsController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all required fields',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Get.toNamed(
      '/add-card',
      arguments: {
        'doctor': doctor.value,
        'date': appointmentDate.value,
        'time': appointmentTime.value,
      },
    );
  }
}
