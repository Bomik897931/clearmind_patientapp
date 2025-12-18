// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../data/models/doctor_model.dart';
//
// class WriteReviewController extends GetxController {
//   final Rx<DoctorModel?> doctor = Rx<DoctorModel?>(null);
//   final reviewController = TextEditingController();
//   final RxDouble rating = 0.0.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     final args = Get.arguments;
//     if (args != null && args['doctor'] != null) {
//       doctor.value = args['doctor'];
//     }
//   }
//
//   @override
//   void onClose() {
//     reviewController.dispose();
//     super.onClose();
//   }
//
//   void onRatingChanged(double value) {
//     rating.value = value;
//   }
//
//   void onSubmit() {
//     if (rating.value == 0 || reviewController.text.isEmpty) {
//       Get.snackbar(
//         'Error',
//         'Please provide rating and review',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }
//
//     Get.snackbar(
//       'Success',
//       'Review submitted successfully',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//     Get.back();
//   }
//
//   void onCancel() {
//     Get.back();
//   }
// }
