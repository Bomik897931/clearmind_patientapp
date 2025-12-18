// import 'package:get/get.dart';
// import '../../../data/models/doctor_model.dart';
//
// class BookAppointmentController extends GetxController {
//   final Rx<DoctorModel?> doctor = Rx<DoctorModel?>(null);
//   final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
//   final RxString selectedTime = ''.obs;
//   final RxBool isReschedule = false.obs;
//
//   final List<String> timeSlots = [
//     '09:00 AM',
//     '09:30 AM',
//     '10:00 AM',
//     '10:30 AM',
//     '11:00 AM',
//     '11:30 AM',
//     '12:00 PM',
//     '12:30 AM',
//     '02:00 AM',
//   ];
//
//   @override
//   void onInit() {
//     super.onInit();
//     final args = Get.arguments;
//     if (args != null) {
//       doctor.value = args['doctor'];
//       isReschedule.value = args['reschedule'] ?? false;
//     }
//   }
//
//   void onDateSelected(DateTime date) {
//     selectedDate.value = date;
//   }
//
//   void onTimeSelected(String time) {
//     selectedTime.value = time;
//   }
//
//   void onNext() {
//     if (selectedDate.value == null || selectedTime.value.isEmpty) {
//       Get.snackbar(
//         'Error',
//         'Please select date and time',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }
//
//     Get.toNamed(
//       '/patient-details',
//       arguments: {
//         'doctor': doctor.value,
//         'date': selectedDate.value,
//         'time': selectedTime.value,
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/doctor_model.dart';
import '../../../data/models/slot_model.dart';
import '../../../data/repositories/appointment_repository.dart';
import '../../../data/services/StorageService.dart';

class BookAppointmentController extends GetxController {
  final AppointmentsRepository _repository;
  final StorageService _storage;

  BookAppointmentController({
    AppointmentsRepository? repository,
    StorageService? storage,
  })  : _repository = repository ?? AppointmentsRepository(),
        _storage = storage ?? StorageService();

  final Rx<DoctorModel?> doctor = Rx<DoctorModel?>(null);
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final Rx<Slot?> selectedSlot = Rx<Slot?>(null);
  final RxBool isReschedule = false.obs;
  final RxBool isLoading = false.obs;
  final RxList<Slot> slots = <Slot>[].obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      doctor.value = args['doctor'];
      isReschedule.value = args['reschedule'] ?? false;
    }

    // Load slots for current date
    if (doctor.value != null) {
      loadSlots(selectedDate.value);
    }
  }

  Future<void> loadSlots(DateTime date) async {
    if (doctor.value == null) return;

    try {
      isLoading.value = true;
      selectedSlot.value = null; // Clear previous selection

      final token = await _storage.getToken();
      if (token == null) {
        Get.snackbar('Error', 'Please login first');
        Get.offAllNamed('/login');
        return;
      }

      // Format date as M/d/yyyy (e.g., 1/30/2026)
      final formattedDate = DateFormat('M/d/yyyy').format(date);

      print('🔵 Controller: Loading slots for date: $formattedDate');

      final fetchedSlots = await _repository.getDoctorSlots(
        token: token,
        doctorId: doctor.value!.userId,
        date: formattedDate,
      );

      slots.value = fetchedSlots;
      print('🟢 Controller: Loaded ${fetchedSlots.length} slots');

      if (fetchedSlots.isEmpty) {
        Get.snackbar(
          'No Slots Available',
          'No appointment slots available for this date',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('🔴 Controller: Error loading slots - $e');
      Get.snackbar(
        'Error',
        'Failed to load appointment slots',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onDateSelected(DateTime date) {
    selectedDate.value = date;
    loadSlots(date); // Reload slots when date changes
  }

  void onSlotSelected(Slot slot) {
    if (slot.isAvailable) {
      selectedSlot.value = slot;
    } else {
      Get.snackbar(
        'Unavailable',
        'This slot is already booked',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }

  void onNext() {
    if (selectedSlot.value == null) {
      Get.snackbar(
        'Error',
        'Please select a time slot',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    Get.toNamed(
      '/patient-details',
      arguments: {
        'doctor': doctor.value,
        'slot': selectedSlot.value,
        'date': selectedDate.value,
      },
    );
  }
}