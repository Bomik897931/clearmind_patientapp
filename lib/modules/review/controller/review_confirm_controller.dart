import 'package:Clarminds/data/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewConfirmController extends GetxController {
  // Data received from previous screen
  late DoctorModel doctor;
  late DateTime selectedDate;
  late String selectedTime;
  late String consultationDuration;
  late String selectedIdProof;
  late String age;
  late String gender;

  final consultationFee = 400.obs;
  final totalAmountController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    // 🔥 STATIC DOCTOR DATA
    // doctor = DoctorModel(
    //   id: 1,
    //   fullName: 'Dr. Rajesh Kumar',
    //   specialty: 'Cardiologist',
    //   imageUrl:
    //   'https://images.pexels.com/photos/8460157/pexels-photo-8460157.jpeg',
    // );

    // 🔥 STATIC APPOINTMENT DATA
    selectedDate = DateTime(2026, 1, 12);
    selectedTime = '10:30 AM';
    consultationDuration = '30 mins';
    selectedIdProof = 'Aadhaar Card';
    age = '28';
    gender = 'Male';

    // 🔥 BILL
    totalAmountController.text = '₹ ${consultationFee.value}';

    // final args = Get.arguments;
    //
    // // 🔍 Debug runtime types (safe to remove later)
    // debugPrint('doctor -> ${args['doctor'].runtimeType}');
    // debugPrint('selectedDate -> ${args['selectedDate'].runtimeType}');
    // debugPrint('selectedTime -> ${args['selectedTime'].runtimeType}');
    // debugPrint('consultationDuration -> ${args['consultationDuration'].runtimeType}');
    // debugPrint('selectedIdProof -> ${args['selectedIdProof'].runtimeType}');
    // debugPrint('age -> ${args['age'].runtimeType}');
    // debugPrint('gender -> ${args['gender'].runtimeType}');
    //
    // // ✅ Assignments with proper types
    // doctor = args['doctor'] as DoctorModel;
    //
    // selectedDate = args['selectedDate'] as DateTime;
    //
    // // ✅ FIX: Handle DateTime OR String safely
    // final timeArg = args['selectedTime'];
    // if (timeArg is DateTime) {
    //   selectedTime = _formatTime(timeArg);
    // } else {
    //   selectedTime = timeArg.toString();
    // }
    //
    // consultationDuration = args['consultationDuration'].toString();
    // selectedIdProof = args['selectedIdProof'].toString();
    // age = args['age'].toString();
    // gender = args['gender'].toString();
    //
    // // Initialize total amount
    // totalAmountController.text = '₹ ${consultationFee.value}';
  }

  // 📅 Date formatter
  String getFormattedDate() {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${selectedDate.day} ${months[selectedDate.month - 1]}, ${selectedDate.year}';
  }

  // ⏰ Time formatter
  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void proceedToPay() {
    Get.toNamed('/payment');
  }

  @override
  void onClose() {
    totalAmountController.dispose();
    super.onClose();
  }
}
