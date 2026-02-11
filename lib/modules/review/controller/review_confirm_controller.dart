import 'package:Clarminds/data/services/StorageService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/appointment_model.dart';
import '../../../data/models/doctor_model.dart';
import '../../../data/repositories/payment_repository.dart';
import '../../../data/services/payment_service.dart';

class ReviewConfirmController extends GetxController {
  // Dependencies
  final StorageService _storage = Get.find();
  final PaymentRepository paymentRepository = PaymentRepository();

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

    debugPrint('✅ Data loaded successfully');
    debugPrint('  Appointment ID: $appointmentId');
    debugPrint('  Consultation Fee: ${consultationFee.value}');
    debugPrint('  Doctor: ${doctor?.fullName}');
  }

  void proceedToPay() {
    debugPrint('🟢 Initiating payment');
    debugPrint('  Amount: ${consultationFee.value}');
    debugPrint('  Appointment ID: $appointmentId');

    _paymentService.openCheckout(
      amount: consultationFee.value.toDouble(), // Use actual fee
      name: doctor?.fullName ?? 'Doctor',
      description: 'Doctor Consultation Fee',
      email: "test@example.com",
      contact: "9999999999",
    );
  }

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

  // ✅ Payment Success Handler
  Future<void> _onPaymentSuccess(Map<String, dynamic> paymentData) async {
    try {
      debugPrint('🟢 Payment Success Callback Triggered');
      debugPrint('📦 Payment Data Received: $paymentData');

      isBooking.value = true;

      // Extract payment details with correct keys
      final paymentId = paymentData['razorpay_payment_id'];
      final orderId = paymentData['razorpay_order_id']; // Will be null
      final signature = paymentData['razorpay_signature']; // Will be null

      debugPrint('🔍 Extracted Data:');
      debugPrint('  Payment ID: $paymentId');
      debugPrint('  Order ID: $orderId');
      debugPrint('  Signature: $signature');

      // Validate payment ID
      if (paymentId == null || paymentId.isEmpty) {
        debugPrint('🔴 Payment ID is missing');
        Get.snackbar(
          'Error',
          'Invalid payment response',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Get token
      final token = await _storage.getToken();
      if (token == null) {
        debugPrint('🔴 Token is missing');
        Get.snackbar('Error', 'Authentication token not found');
        return;
      }

      debugPrint('🔑 Token retrieved successfully');

      // Call backend to confirm payment
      debugPrint('📤 Calling backend to confirm payment...');

      final success = await paymentRepository.confirmPayment(
        appointmentId: int.parse(appointmentId),
        amount: consultationFee.value,
        paymentId: paymentId,
        orderId: orderId, // Can be null
        signature: signature, // Can be null
        token: token,
      );

      debugPrint('📥 Backend response: ${success ? "SUCCESS" : "FAILED"}');

      if (success) {
        debugPrint('✅ Payment confirmed successfully');

        // Navigate to appointments
        Get.offAllNamed('/my-appointments');

        // Show success message
        Get.snackbar(
          'Success',
          'Payment confirmed & appointment booked successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.TOP,
        );
      } else {
        debugPrint('🔴 Payment confirmation failed');
        Get.snackbar(
          'Error',
          'Payment confirmation failed. Please contact support.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
        );
      }
    } on RepositoryException catch (e) {
      debugPrint('🔴 Repository Exception: ${e.message}');
      Get.snackbar(
        'Error',
        e.message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } catch (e) {
      debugPrint('🔴 Unexpected error in payment success: $e');
      Get.snackbar(
        'Error',
        'Failed to confirm payment: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isBooking.value = false;
    }
  }

  void _onPaymentError(String message) {
    debugPrint('🔴 Payment Error Callback Triggered');
    debugPrint('  Error Message: $message');

    Get.snackbar(
      'Payment Failed',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      snackPosition: SnackPosition.TOP,
    );
  }

  @override
  void onClose() {
    debugPrint('🔄 Disposing PaymentService');
    _paymentService.dispose();
    super.onClose();
  }
}