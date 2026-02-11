/*
import 'package:get/get.dart';

class PaymentController extends GetxController {
  final RxString selectedPaymentMethod = 'visa'.obs;

  void onPaymentMethodSelected(String method) {
    selectedPaymentMethod.value = method;
  }

  void onNext() {
    // Process payment and navigate to success screen
    Get.snackbar(
      'Success',
      'Payment processed successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.offAllNamed('/home');
  }

  void onAddNewCard() {
    Get.toNamed('/add-card');
  }
}
*/

import 'package:Clarminds/core/constants/app_strings.dart';
import 'package:Clarminds/core/routes/app_routes.dart';
import 'package:Clarminds/data/repositories/payment_repository.dart';
import 'package:Clarminds/data/services/payment_service.dart';
import 'package:get/get.dart';

import '../../../data/services/StorageService.dart';

class PaymentController extends GetxController {
  final PaymentService _razorpayService = PaymentService();
  final PaymentRepository _repository;
  final StorageService _storage;

  PaymentController({
    PaymentRepository? repository,
    StorageService? storage,
  })  : _repository = repository ?? PaymentRepository(),
        _storage = storage ?? StorageService();

  final isProcessing = false.obs;

  late int appointmentId;
  late int amount;

  @override
  void onInit() {
    super.onInit();

    _razorpayService.onPaymentSuccess = _onPaymentSuccess;
    _razorpayService.onPaymentError = _onPaymentError;
  }

  void startPayment({
    required int appointmentId,
    required int amount,
    required String name,
    String? email,
    String? contact,
  }) {
    this.appointmentId = appointmentId;
    this.amount = amount;

    _razorpayService.openCheckout(
      amount: 1,
      name: name,
      description: 'Doctor Consultation Fee',
      email: email,
      contact: contact,
    );
  }

  Future<void> _onPaymentSuccess(Map<String, dynamic> paymentData) async {
    try {
      isProcessing.value = true;

      final token = await _storage.getToken();
      final success = await _repository.confirmPayment(
        appointmentId: appointmentId,
        amount: amount,
        paymentId: paymentData['razorpayPaymentId'],
        signature: paymentData['razorpaySignature'],
        token: token!
      );

      if (success) {
        Get.offNamed(AppRoutes.MY_APPOINTMENTS);
        Get.snackbar('Success', 'Payment confirmed & appointment booked');
      } else {
        Get.snackbar('Error', 'Payment confirmation failed');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isProcessing.value = false;
    }
  }

  void _onPaymentError(String message) {
    Get.snackbar('Payment Failed', message);
  }

  @override
  void onClose() {
    _razorpayService.dispose();
    super.onClose();
  }
}
