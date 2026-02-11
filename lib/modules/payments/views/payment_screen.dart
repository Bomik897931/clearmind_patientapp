import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/payment_controller.dart';

class PaymentScreen extends GetView<PaymentController> {
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Center(
        child: Obx(() => ElevatedButton(
          onPressed: controller.isProcessing.value
              ? null
              : () => controller.startPayment(
            appointmentId: args['appointmentId'],
            amount: args['amount'],
            name: args['doctorName'],
            email: args['email'],
            contact: args['contact'],
          ),
          child: controller.isProcessing.value
              ? const CircularProgressIndicator()
              : const Text('Pay Now'),
        )),
      ),
    );
  }
}
