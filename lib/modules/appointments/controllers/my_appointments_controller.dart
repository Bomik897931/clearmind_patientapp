// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../data/models/appointment_model.dart';
// import '../../../data/models/doctor_model.dart';
//
// class MyAppointmentsController extends GetxController
//     with GetSingleTickerProviderStateMixin {
//   late TabController tabController;
//   final RxList<AppointmentModel> upcomingAppointments =
//       <AppointmentModel>[].obs;
//   final RxList<AppointmentModel> completedAppointments =
//       <AppointmentModel>[].obs;
//   final RxBool isLoading = false.obs;
//   final RxInt selectedBottomIndex = 1.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     tabController = TabController(length: 2, vsync: this);
//     loadAppointments();
//   }
//
//   @override
//   void onClose() {
//     tabController.dispose();
//     super.onClose();
//   }
//
//   void loadAppointments() {
//     isLoading.value = true;
//
//     // Mock data - Replace with API call
//     final mockDoctor = DoctorModel(
//       id: '1',
//       name: 'Dr. Marvin Boeson',
//       specialty: 'Cardiologist',
//       hospital: 'Christ Hospital in London UK',
//       image: '',
//       rating: 4.9,
//       reviewCount: 4945,
//       experience: 5,
//     );
//
//     upcomingAppointments.value = [
//       AppointmentModel(
//         id: '1',
//         doctor: mockDoctor,
//         date: DateTime.now().add(const Duration(days: 1)),
//         time: '05:00 PM',
//         status: 'messaging',
//         type: 'messaging',
//         price: 20,
//       ),
//       AppointmentModel(
//         id: '2',
//         doctor: mockDoctor.copyWith(name: 'Dr. Drake Mickin'),
//         date: DateTime.now().add(const Duration(days: 2)),
//         time: '04:00 PM',
//         status: 'upcoming',
//         type: 'voice_call',
//         price: 30,
//       ),
//       AppointmentModel(
//         id: '3',
//         doctor: mockDoctor.copyWith(name: 'Dr. Maria Foose'),
//         date: DateTime.now().add(const Duration(days: 3)),
//         time: '02:00 PM',
//         status: 'upcoming',
//         type: 'video_call',
//         price: 50,
//       ),
//     ];
//
//     completedAppointments.value = [
//       AppointmentModel(
//         id: '4',
//         doctor: mockDoctor,
//         date: DateTime.now().subtract(const Duration(days: 5)),
//         time: '03:00 PM',
//         status: 'completed',
//         type: 'video_call',
//         price: 50,
//       ),
//     ];
//
//     isLoading.value = false;
//   }
//
//   void onAppointmentTap(AppointmentModel appointment) {
//     Get.toNamed('/appointment-detail', arguments: {'appointment': appointment});
//   }
//
//   void onReschedule(AppointmentModel appointment) {
//     Get.toNamed(
//       '/book-appointment',
//       arguments: {
//         'doctor': appointment.doctor,
//         'reschedule': true,
//         'appointmentId': appointment.id,
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Clarminds/data/repositories/user_repository.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/routes/app_routes.dart';
import '../../../data/models/appointment_model.dart';
import '../../../data/repositories/agora_repository.dart';
import '../../../data/repositories/appointment_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../data/services/StorageService.dart';
import '../../../widgets/cancel_appointment_dialog.dart';

class MyAppointmentsController extends GetxController with GetSingleTickerProviderStateMixin {
  final AppointmentsRepository _repository;
  final StorageService _storage;

  MyAppointmentsController({
    AppointmentsRepository? repository,
    StorageService? storage,
  })  : _repository = repository ?? AppointmentsRepository(),
        _storage = storage ?? StorageService();

  late TabController tabController;

  final RxList<Appointment> upcomingAppointments = <Appointment>[].obs;
  final RxList<Appointment> completedAppointments = <Appointment>[].obs;
  final RxList<Appointment> cancelledAppointments = <Appointment>[].obs;
  final RxBool isLoading = false.obs;
  final RxInt selectedBottomIndex = 1.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    loadAppointments();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future<void> loadAppointments() async {
    try {
      isLoading.value = true;

      final token = await _storage.getToken();
      if (token == null) {
        Get.snackbar('Error', 'Please login first');
        Get.offAllNamed('/login');
        return;
      }

      final response = await _repository.getAppointments(
        token: token,
        pageNumber: 1,
        pageSize: 100,
      );

      final now = DateTime.now();

      // Filter appointments by status and date
      upcomingAppointments.value = response.items.where((apt) {
        final status = apt.status.toLowerCase();
        try {
          final appointmentDate = DateTime.parse(apt.appointmentDate);
          // Only show confirmed/pending appointments that are today or in the future
          return (status == 'confirmed' || status == 'pending') &&
              appointmentDate.isAfter(now.subtract(const Duration(days: 1)));
        } catch (e) {
          return status == 'confirmed' || status == 'pending';
        }
      }).toList();

      completedAppointments.value = response.items
          .where((apt) => apt.status.toLowerCase() == 'completed')
          .toList();

      cancelledAppointments.value = response.items
          .where((apt) => apt.status.toLowerCase() == 'cancelled')
          .toList();

      print('🟢 Loaded: ${upcomingAppointments.length} upcoming, '
          '${completedAppointments.length} completed, '
          '${cancelledAppointments.length} cancelled');

    } catch (e) {
      print('🔴 Error loading appointments: $e');
      Get.snackbar(
        'Error',
        'Failed to load appointments',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onAppointmentTap(Appointment appointment) {
    // Navigate to appointment details
    Get.toNamed('/appointment-details', arguments: {'appointment': appointment});
  }

  void onReschedule(Appointment appointment) {
    // Navigate to reschedule screen
    Get.toNamed('/book-appointment', arguments: {
      'appointment': appointment,
      'reschedule': true,
    });
  }
  void showCancelDialog(Appointment appointment) {
    Get.dialog(
      CancelAppointmentDialog(
        appointment: appointment,
        onConfirm: () => onCancelAppointment(appointment),
      ),
      barrierDismissible: true,
    );
  }

  Future<void> onCancelAppointment(Appointment appointment) async {
    try {
      Get.back(); // Close dialog

      // Show loading
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(
            color: AppColors.circularprogressindicator,
          ),
        ),
        barrierDismissible: false,
      );

      final token = await _storage.getToken();
      if (token == null) {
        Get.back();
        Get.snackbar('Error', 'Please login first');
        return;
      }

      final success = await _repository.cancelAppointment(
        token: token,
        appointmentId: appointment.appointmentId,
      );

      Get.back(); // Close loading

      if (success) {
        Get.snackbar(
          'Success',
          'Appointment cancelled successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.green,
          colorText: AppColors.white,
          duration: const Duration(seconds: 2),
        );

        // Refresh appointments list
        await loadAppointments();
      } else {
        Get.snackbar(
          'Error',
          'Failed to cancel appointment',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
        );
      }
    } catch (e) {
      Get.back(); // Close loading if open
      print('🔴 Error cancelling appointment: $e');
      Get.snackbar(
        'Error',
        'Failed to cancel appointment',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    }
  }

  // void onLeaveReview(Appointment appointment) {
  //   print("srdfyghjikolp $appointment");
  //   // Navigate to review screen
  //   Get.toNamed(AppRoutes.WRITE_REVIEW, arguments: {'appointment': appointment});
  // }
  void onLeaveReview(Appointment appointment) {
    print("Opening review for: ${appointment.doctorName}");
    Get.toNamed(
      AppRoutes.WRITE_REVIEW,
      arguments: {
        'doctorId': appointment.doctorUserId ?? 0,
        'doctorName': appointment.doctorName,
        'appointmentId': appointment.appointmentId,
      },
    );
    // Get.toNamed(
    //   AppRoutes.REVIEWS_LIST,
    //   arguments: {
    //     'doctorId': appointment.doctorUserId ?? 0,
    //     // 'doctorName': appointment.doctorName,
    //     // 'appointmentId': appointment.appointmentId,
    //   },
    // );
  }

  void onBookAgain(Appointment appointment) {
    // Navigate to book appointment with same doctor
    Get.toNamed('/book-appointment', arguments: {
      'doctorId': appointment.doctorUserId,
    });
  }

  void onCall(Appointment appointment) async{
    // Implement call functionality
    try {
      // Show loading
      // Get.dialog(
      //   const Center(child: CircularProgressIndicator()),
      //   barrierDismissible: false,
      // );

      final storage = StorageService();
      final token = await storage.getToken();

      if (token == null) {
        Get.back(); // Close loading
        Get.snackbar('Error', 'Please login first');
        return;
      }

      // Get Agora token from API
      final agoraRepo = AgoraRepository();
      final agoraToken = await agoraRepo.getAgoraToken(
        token: token,
        appointmentId: appointment.appointmentId,
      );

      // Get.back(); // Close loading

      // Navigate to video call screen with token
      Get.toNamed(
        '/video-call',
        arguments: {
          'appId': agoraToken.appId,
          'channelName': agoraToken.channelName,
          'token': agoraToken.token,
          'uid': agoraToken.uid,
          'appointmentId':appointment.appointmentId
        },
      );
    } on RepositoryException catch (e) {
      // Get.back();

      if (e.message.contains('already connected')) {
        // Show dialog with force disconnect option
        Get.dialog(
          AlertDialog(
            title: Row(
              children: [
                Icon(Icons.warning_amber, color: AppColors.orange, size: 28),
                SizedBox(width: 12),
                Text('Already Connected'),
              ],
            ),
            content: Text(
              'Patient already connected to this call on another device. Please disconnect there and try again.',
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text(AppStrings.cancel),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                  // onCall(appointment);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text('Disconnect'),
              ),
            ],
          ),
        );
      } else {
        Get.snackbar(
          'Error',
          e.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
    catch (e) {
      // Get.back(); // Close loading
      print('Error joining call: $e');
      Get.snackbar(
        'Error',
        'Failed to join call. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }


    // Get.snackbar(
    //   'Call',
    //   'Calling ${appointment.doctorName}...',
    //   snackPosition: SnackPosition.BOTTOM,
    // );
  }
}