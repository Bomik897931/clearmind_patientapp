import 'package:get/get.dart';
import '../../../data/models/appointment_model.dart';

class AppointmentDetailController extends GetxController {
  final Rx<Appointment?> appointment = Rx<Appointment?>(null);

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['appointment'] != null) {
      appointment.value = args['appointment'];
    }
  }

  void onStartMessaging() {
    Get.toNamed('/chat', arguments: {'appointment': appointment.value});
  }

  void onStartVoiceCall() {
    // Navigate to voice call screen (you can implement this)
    Get.snackbar('Voice Call', 'Starting voice call...');
  }

  void onStartVideoCall() {
    Get.toNamed('/video-call', arguments: {'appointment': appointment.value});
  }
}
