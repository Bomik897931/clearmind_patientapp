import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/models/appointment_model.dart';
import '../../../data/models/doctor_model.dart';
import '../../../data/services/StorageService.dart';
import '../../../data/services/payment_service.dart';

class ReviewConfirmController extends GetxController {
  // Dependencies
  final StorageService _storage = Get.find();

  // Models
  DoctorModel? doctor;
  Appointment? appointment;

  // Appointment data
  DateTime? selectedDate;
  String selectedTime = '';
  String consultationDuration = '';
  String gender = '';
  String selectedIdProof = '';
  String appointmentId = '';

  // Observables
  final consultationFee = 0.obs;
  final isBooking = false.obs;
  final isDataLoaded = false.obs;
  final hasError = false.obs;

  late PaymentService _paymentService;

  @override
  void onInit() {
    super.onInit();
    _paymentService = PaymentService();
    _paymentService.onPaymentSuccess = _onPaymentSuccess;
    _paymentService.onPaymentError = _onPaymentError;
  }

  @override
  void onReady() {
    super.onReady();
    _loadData();
  }

  // ==========================
  // LOAD DATA SAFELY
  // ==========================
  void _loadData() {
    final args = Get.arguments;

    debugPrint('🟡 ReviewConfirm args: $args');

    if (args == null) {
      hasError.value = true;
      isDataLoaded.value = false;
      return;
    }

    appointment = args['appointment'];
    doctor = args['doctor'];

    if (appointment == null || doctor == null) {
      debugPrint('🔴 Missing appointment or doctor');
      hasError.value = true;
      isDataLoaded.value = false;
      return;
    }

    selectedDate = DateTime.tryParse(appointment!.appointmentDate);
    selectedTime = appointment!.time ?? '';
    consultationDuration = appointment!.slotsDuration.toString();
    consultationFee.value = appointment!.slotsFees?.toInt() ?? 0;
    gender = appointment!.gender ?? '';
    appointmentId = appointment!.appointmentId.toString();

    isDataLoaded.value = true;
  }

  // ==========================
  // DATE FORMAT
  // ==========================
  String getFormattedDate() {
    if (selectedDate == null) return 'Not selected';

    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    return '${selectedDate!.day} '
        '${months[selectedDate!.month - 1]}, '
        '${selectedDate!.year}';
  }

  // ==========================
  // PAYMENT CALLBACKS
  // ==========================
  Future<void> _onPaymentSuccess(Map<String, dynamic> paymentData) async {
    Get.snackbar(
      'Success',
      'Appointment booked successfully',
      backgroundColor: AppColors.circularprogressindicator,
      colorText: Colors.white,
    );

    await Future.delayed(const Duration(seconds: 1));
    Get.offAllNamed('/my-appointments');
  }

  void _onPaymentError(String message) {
    Get.snackbar(
      'Payment Failed',
      message,
      backgroundColor: AppColors.red,
      colorText: Colors.white,
    );
  }
}
