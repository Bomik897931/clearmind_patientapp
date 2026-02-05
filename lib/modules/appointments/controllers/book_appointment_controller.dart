// import 'package:get/get.dart';
// import '../../../data/models/doctor_model.dart';
//
// class BookAppointmentController extends GetxController {
//   final Rx<DoctorModel?> doctor = Rx<DoctorModel?>(null);
//   final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
//   final RxString selectedTime = ''.obs;
//   final RxBool isReschedule = false.obs;
//
//   final List<String> timeSlots = [
//     '09:00 AM',
//     '09:30 AM',
//     '10:00 AM',
//     '10:30 AM',
//     '11:00 AM',
//     '11:30 AM',
//     '12:00 PM',
//     '12:30 AM',
//     '02:00 AM',
//   ];
//
//   @override
//   void onInit() {
//     super.onInit();
//     final args = Get.arguments;
//     if (args != null) {
//       doctor.value = args['doctor'];
//       isReschedule.value = args['reschedule'] ?? false;
//     }
//   }
//
//   void onDateSelected(DateTime date) {
//     selectedDate.value = date;
//   }
//
//   void onTimeSelected(String time) {
//     selectedTime.value = time;
//   }
//
//   void onNext() {
//     if (selectedDate.value == null || selectedTime.value.isEmpty) {
//       Get.snackbar(
//         'Error',
//         'Please select date and time',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }
//
//     Get.toNamed(
//       '/patient-details',
//       arguments: {
//         'doctor': doctor.value,
//         'date': selectedDate.value,
//         'time': selectedTime.value,
//       },
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/models/appointment_request_model.dart';
import '../../../data/models/doctor_model.dart';
import '../../../data/models/identity_doc_type_model.dart';
import '../../../data/models/slot_model.dart';
import '../../../data/repositories/appointment_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../data/services/StorageService.dart';

class BookAppointmentController extends GetxController {
  final AppointmentsRepository _repository;
  final StorageService _storage;

  BookAppointmentController({
    AppointmentsRepository? repository,
    StorageService? storage,
  }) : _repository = repository ?? AppointmentsRepository(),
       _storage = storage ?? StorageService();

  final Rx<DoctorModel?> doctor = Rx<DoctorModel?>(null);
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final Rx<Slot?> selectedSlot = Rx<Slot?>(null);
  final RxBool isReschedule = false.obs;
  final RxBool isLoading = false.obs;
  final RxList<Slot> slots = <Slot>[].obs;
  final selectedDuration = '10'.obs;
  final ageController = TextEditingController();
  final patientNameController = TextEditingController();
  final selectedGender = ''.obs;
  final selectedIdProof = ''.obs;
  final displayMonth = DateTime.now().obs;
  var showIdNumberField = false.obs;
  final idNumberHint = ''.obs;
  final RxList<Slot> selectedSlots = <Slot>[].obs;
  final idNumberController = TextEditingController();
  final RxList<IdentityDocType> identityDocTypes = <IdentityDocType>[].obs;

  final dob = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      doctor.value = args['doctor'];
      isReschedule.value = args['reschedule'] ?? false;
    }

    fetchPatientProfile();
    print("sdxfcghbjkml,;");
    fetchIdentityDocumentTypes();
    print("sdxfcghbjkml,7777;");
    // Load slots for current date
    if (doctor.value != null) {
      loadSlots(selectedDate.value);
    }
  }

  void previousMonth() {
    displayMonth.value = DateTime(
      displayMonth.value.year,
      displayMonth.value.month - 1,
    );
  }

  void nextMonth() {
    displayMonth.value = DateTime(
      displayMonth.value.year,
      displayMonth.value.month + 1,
    );
  }
  Future<void> fetchPatientProfile() async {
    try {
      final token = await _storage.getToken();
      if (token == null) return;

      final response = await _repository.getPatientProfile(token: token);

      // 🔹 Name
      final firstName = response['firstName'] ?? '';
      final lastName = response['lastName'] ?? '';
      patientNameController.text = '$firstName $lastName'.trim();

      // 🔹 DOB → Age
      final dobString = response['dob'];
      if (dobString != null) {
        final parsedDob = DateTime.parse(dobString);
        dob.value = parsedDob;

        final now = DateTime.now();
        int age = now.year - parsedDob.year;
        if (now.month < parsedDob.month ||
            (now.month == parsedDob.month && now.day < parsedDob.day)) {
          age--;
        }
        ageController.text = age.toString();
      }

      // 🔹 Gender
      final genderApi = response['gender'];
      if (genderApi != null && genderApi.toString().isNotEmpty) {
        selectedGender.value =
            genderApi[0].toUpperCase() + genderApi.substring(1);
      }

      // 🔹 Identity Docs (AUTO SELECT)
      final List identityDocs = response['identityDocs'] ?? [];

      if (identityDocs.isNotEmpty) {
        final doc = identityDocs.first;

        final int documentType = doc['documentType'];
        final String documentNumber = doc['documentNumber'] ?? '';

        final mappedDocName = mapDocumentType(documentType);

        selectedIdProof.value = mappedDocName;
        idNumberController.text = documentNumber;
        showIdNumberField.value = true;

        // Hint text
        idNumberHint.value = 'Enter $mappedDocName Number';
      }
    } catch (e) {
      print('❌ Error fetching patient profile: $e');
    }
  }


  Future<void> fetchIdentityDocumentTypes() async {
    try {
      print("sdxfcghbjkml,;");
      final token = await _storage.getToken();
      print(token);
      if (token == null) return;

      final response = await _repository.getIdentityDocumentTypes(token: token);

      final List data = response['data'] ?? [];

      identityDocTypes.value =
          data.map((e) => IdentityDocType.fromJson(e)).toList();

    } catch (e) {
      print('❌ Error fetching identity doc types: $e');
    }
  }


  Future<void> loadSlots(DateTime date) async {
    if (doctor.value == null) return;

    try {
      isLoading.value = true;
      selectedSlot.value = null; // Clear previous selection

      final token = await _storage.getToken();
      if (token == null) {
        Get.snackbar('Error', 'Please login first');
        Get.offAllNamed('/login');
        return;
      }

      // Format date as M/d/yyyy (e.g., 1/30/2026)
      final formattedDate = DateFormat('M/d/yyyy').format(date);

      print('🔵 Controller: Loading slots for date: $formattedDate');

      final fetchedSlots = await _repository.getDoctorSlots(
        token: token,
        doctorId: doctor.value!.userId,
        date: formattedDate,
        slotDuration: int.parse(selectedDuration.value),
      );

      slots.value = fetchedSlots;
      print('🟢 Controller: Loaded ${fetchedSlots.length} slots');

      if (fetchedSlots.isEmpty) {
        Get.snackbar(
          'No Slots Available',
          'No appointment slots available for this date',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.orange,
          colorText: AppColors.white,
        );
      }
    } catch (e) {
      print('🔴 Controller: Error loading slots - $e');
      Get.snackbar(
        'Error',
        'Failed to load appointment slots',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onDateSelected(DateTime date) {
    selectedDate.value = date;
    loadSlots(date); // Reload slots when date changes
  }

  /*void onSlotSelected(Slot slot) {
    if (slot.isAvailable) {
      selectedSlot.value = slot;
    } else {
      Get.snackbar(
        'Unavailable',
        'This slot is already booked',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.orange,
        colorText: AppColors.white,
      );
    }
  }*/
  void onSlotSelected(Slot slot) {
    if (selectedSlots.contains(slot)) {
      // Deselect if already selected
      selectedSlots.remove(slot);
    } else {
      // Add to selection
      selectedSlots.add(slot);
    }
  }

  // Check if a slot is selected
  bool isSlotSelected(Slot slot) {
    return selectedSlots.any((s) => s.slotId == slot.slotId);
  }

  Future<void> bookAppointment() async {
    // if (selectedSlot.value == null) {
    //   Get.snackbar('Error', 'Please select a slot');
    //   return;
    // }

    // if (reasonController.text.trim().isEmpty) {
    //   Get.snackbar('Error', 'Please enter reason for appointment');
    //   return;
    // }

    // Use doctor ID from selected slot if not passed from arguments
    final finalDoctorUserId = doctor.value!.userId;

    try {
      // isBooking.value = true;

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

      // final request = BookAppointmentRequest(
      //   doctorUserId: finalDoctorUserId,
      //   patientUserId: user.userId!,
      //   slotDuration: int.parse(selectedDuration.value),
      //   slotId: /*selectedSlot.value!.slotIds*/ selectedSlots
      //       .map((slot) => slot.slotId)
      //       .toList(),
      //   reason: "",
      //   notes: "",
      // );
      final request = BookAppointmentRequest(
        doctorUserId: finalDoctorUserId,
        patientUserId: user.userId!,
        slotIds: selectedSlots.map((e) => e.slotId).toList(),
        slotsDuration: int.parse(selectedDuration.value),
        reason: "fiver",
        notes: "high fiver",
        patientProfile: PatientProfile(
          firstName: "babar",
          lastName: "khan",
          dob: "2006-02-02T13:51:51.677Z",
          gender: "male",
          identityDocs: [
            IdentityDoc(
              documentType: 2,
              documentNumber: "678990543212",
              isVerified: true,
            ),
          ],
        ),
      );
      print(request);

      final appointment = await _repository.bookAppointment(
        token: token,
        request: request,
      );

      print('🟢 Controller: Appointment booked successfully');

      // Clear form
      // reasonController.clear();
      // notesController.clear();
      selectedSlot.value = null;

      Get.snackbar(
        'Success',
        'Appointment booked successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.circularprogressindicator,
        colorText: AppColors.white,
        duration: const Duration(seconds: 3),
      );

      // Navigate to my appointments after short delay
      await Future.delayed(const Duration(seconds: 2));
      // Get.toNamed(
      //   '/review-confirm',
      //   arguments: {
      //     'doctor': doctor.value,
      //     'selectedDate': selectedDate.value,
      //     'selectedTime': "",
      //     'selectedSlots': selectedSlots.toList(),
      //     'selectedDuration': selectedDuration.value,
      //     'consultationDuration': selectedDuration.value,
      //     'selectedIdProof': selectedIdProof.value,
      //     'consultationFee': "500",
      //     'age': "28",
      //     'gender': "Male",
      //   },
      // );
      Get.toNamed(
        '/review-confirm',
        arguments: {
          "appointment": appointment,
          "doctor": doctor.value,
        },
      );
      // Get.offAllNamed('/my-appointments');
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
      // isBooking.value = false;
    }
  }

  void onNext() {
    if (selectedSlot.value == null) {
      Get.snackbar(
        'Error',
        'Please select a time slot',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    Get.toNamed(
      '/patient-details',
      arguments: {
        'doctor': doctor.value,
        'slot': selectedSlot.value,
        'date': selectedDate.value,
      },
    );
  }

  String mapDocumentType(int type) {
    switch (type) {
      case 0:
        return 'Aadhaar';
      case 1:
        return 'PAN';
      case 2:
        return 'Passport';
      case 3:
        return 'DrivingLicense';
      case 4:
        return 'VoterId';
      default:
        return 'Other';
    }
  }

}
