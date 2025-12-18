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
