/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/constants/app_text_style.dart';
import 'package:patient_app/modules/appointments/widgets.dart/date_time_selector.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../controllers/book_appointment_controller.dart';

class BookAppointmentScreen extends GetView<BookAppointmentController> {
  const BookAppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar:  CustomAppBar(title: AppStrings.bookAppointment),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppDimensions.paddingMD),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDateSection(),
                  SizedBox(height: AppDimensions.paddingLG),
                  _buildTimeSection(),
                  SizedBox(height: AppDimensions.paddingXL),
                ],
              ),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.selectDate, style: AppTextStyles.h6),
        SizedBox(height: AppDimensions.paddingMD),
        Obx(
          () => DateTimeSelector(
            selectedDate: controller.selectedDate.value,
            onDateSelected: controller.onDateSelected,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.selectHour, style: AppTextStyles.h6),
        SizedBox(height: AppDimensions.paddingMD),
        Obx(
          () => Wrap(
            spacing: AppDimensions.paddingSM,
            runSpacing: AppDimensions.paddingSM,
            children: controller.timeSlots.map((time) {
              final isSelected = controller.selectedTime.value == time;
              return InkWell(
                onTap: () => controller.onTimeSelected(time),
                borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingMD,
                    vertical: AppDimensions.paddingSM,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.white,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  child: Text(
                    time,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isSelected
                          ? AppColors.white
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: CustomButton(text: AppStrings.next, onPressed: controller.onNext),
    );
  }
}
*/


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/core/constants/app_strings.dart';

import '../../../widgets/date_time_selector.dart';
import '../controllers/book_appointment_controller.dart';

class BookAppointmentScreen extends GetView<BookAppointmentController> {
  const BookAppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title:  Text(
          AppStrings.bookAppointment,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDoctorCard(),
                  const SizedBox(height: 24),
                  _buildDateSection(),
                  const SizedBox(height: 24),
                  _buildTimeSection(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildDoctorCard() {
    return Obx(() {
      final doc = controller.doctor.value;
      if (doc == null) return const SizedBox();

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(doc.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doc.fullName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doc.specialty,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          AppStrings.selectDate,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Obx(
              () => DateTimeSelector(
            selectedDate: controller.selectedDate.value,
            onDateSelected: controller.onDateSelected,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Available Time Slots',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: CircularProgressIndicator(
                  color: Color(0xFF00BCD4),
                ),
              ),
            );
          }

          if (controller.slots.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.event_busy, size: 48, color: Colors.grey[400]),
                    const SizedBox(height: 12),
                    Text(
                      'No slots available for this date',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: controller.slots.map((slot) {
              final isSelected = controller.selectedSlot.value?.slotId == slot.slotId;
              final isAvailable = slot.isAvailable;

              return InkWell(
                onTap: isAvailable ? () => controller.onSlotSelected(slot) : null,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: !isAvailable
                        ? Colors.grey[200]
                        : isSelected
                        ? const Color(0xFF00BCD4)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: !isAvailable
                          ? Colors.grey[300]!
                          : isSelected
                          ? const Color(0xFF00BCD4)
                          : Colors.grey[300]!,
                    ),
                  ),
                  child: Text(
                    slot.displayTime,
                    style: TextStyle(
                      color: !isAvailable
                          ? Colors.grey[500]
                          : isSelected
                          ? Colors.white
                          : Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      decoration: !isAvailable
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: controller.bookAppointment,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00BCD4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Next',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}