// lib/modules/slots/controllers/slots_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/models/appointment_request_model.dart';
import '../../../data/models/slot_model.dart';
import '../../../data/repositories/slot_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../data/services/StorageService.dart';

class SlotsController extends GetxController {
  final SlotsRepository _slotsRepository;
  final StorageService _storage;

  SlotsController({
    SlotsRepository? slotsRepository,
    StorageService? storage,
  })  : _slotsRepository = slotsRepository ?? SlotsRepository(),
        _storage = storage ?? StorageService();

  final isLoading = false.obs;
  final isBooking = false.obs;
  final slots = <Slot>[].obs;
  final Rx<Slot?> selectedSlot = Rx<Slot?>(null);

  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final hasNext = false.obs;
  final hasPrevious = false.obs;
  final totalCount = 0.obs;

  // Form controllers
  final reasonController = TextEditingController();
  final notesController = TextEditingController();

  // Doctor info - optional (can come from arguments or slot selection)
  int? doctorUserId;
  String? doctorName;

  @override
  void onInit() {
    super.onInit();

    // Check if doctor info passed from arguments (from doctor detail page)
    final args = Get.arguments;
    if (args != null) {
      doctorUserId = args['doctorUserId'];
      doctorName = args['doctorName'];
    }

    fetchSlots();
  }

  @override
  void onClose() {
    reasonController.dispose();
    notesController.dispose();
    super.onClose();
  }

  Future<void> fetchSlots({int page = 1, int pageSize = 10}) async {
    try {
      isLoading.value = true;

      final token = await _storage.getToken();

      if (token == null) {
        Get.snackbar('Error', 'Please login first');
        Get.offAllNamed('/login');
        return;
      }

      print('🔵 Controller: Fetching slots for page $page');

      final response = await _slotsRepository.getSlots(
        token: token,
        pageNumber: page,
        pageSize: pageSize,
      );

      slots.value = response.items;
      currentPage.value = response.pageNumber;
      totalPages.value = response.totalPages;
      hasNext.value = response.hasNext;
      hasPrevious.value = response.hasPrevious;
      totalCount.value = response.totalCount;

      print('🟢 Controller: Fetched ${response.items.length} slots');
    } on RepositoryException catch (e) {
      print('🔴 Controller: RepositoryException - ${e.message}');
      Get.snackbar('Error', e.message);
    } catch (e) {
      print('🔴 Controller: Unexpected error - $e');
      Get.snackbar('Error', 'Failed to load slots');
    } finally {
      isLoading.value = false;
    }
  }

  void selectSlot(Slot slot) {
    if (slot.isAvailable) {
      selectedSlot.value = slot;
      // Set doctor info from selected slot if not already set
      if (doctorUserId == null) {
        doctorUserId = slot.doctorId;
        doctorName = slot.doctorName;
      }
    } else {
      Get.snackbar('Unavailable', 'This slot is already booked');
    }
  }

  Future<void> bookAppointment() async {
    if (selectedSlot.value == null) {
      Get.snackbar('Error', 'Please select a slot');
      return;
    }

    if (reasonController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter reason for appointment');
      return;
    }

    // Use doctor ID from selected slot if not passed from arguments
    final finalDoctorUserId = doctorUserId ?? selectedSlot.value!.doctorId;

    try {
      isBooking.value = true;

      final token = await _storage.getToken();
      final user = await _storage.getUser();

      if (token == null || user == null) {
        Get.snackbar('Error', 'Please login first');
        Get.offAllNamed('/login');
        return;
      }

      if (user.userId == null) {
        Get.snackbar('Error', 'User ID not found. Please login again.');
        Get.offAllNamed('/login');
        return;
      }

      print('🔵 Controller: Booking appointment...');

      final request = BookAppointmentRequest(
        doctorUserId: finalDoctorUserId,
        patientUserId: user.userId!,
        slotId: selectedSlot.value!.slotId,
        reason: reasonController.text.trim(),
        notes: notesController.text.trim(),
      );

      final appointment = await _slotsRepository.bookAppointment(
        token: token,
        request: request,
      );

      print('🟢 Controller: Appointment booked successfully');

      // Clear form
      reasonController.clear();
      notesController.clear();
      selectedSlot.value = null;

      Get.snackbar(
        'Success',
        'Appointment booked successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.green,
        colorText: AppColors.white,
        duration: const Duration(seconds: 3),
      );

      // Navigate to my appointments after short delay
      await Future.delayed(const Duration(seconds: 1));
      Get.offAllNamed('/my-appointments');

    } on RepositoryException catch (e) {
      print('🔴 Controller: RepositoryException - ${e.message}');
      Get.snackbar(
        'Error',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } catch (e) {
      print('🔴 Controller: Unexpected error - $e');
      Get.snackbar(
        'Error',
        'Failed to book appointment',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } finally {
      isBooking.value = false;
    }
  }

  void nextPage() {
    if (hasNext.value) {
      fetchSlots(page: currentPage.value + 1);
    }
  }

  void previousPage() {
    if (hasPrevious.value) {
      fetchSlots(page: currentPage.value - 1);
    }
  }

  Future<void> refresh() async{
    selectedSlot.value = null;
    reasonController.clear();
    notesController.clear();
    fetchSlots(page: 1);
  }
}