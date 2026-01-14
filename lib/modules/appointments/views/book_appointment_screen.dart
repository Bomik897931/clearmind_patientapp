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

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/date_time_selector.dart';
import '../controllers/book_appointment_controller.dart';

/*
class BookAppointmentScreen extends GetView<BookAppointmentController> {
  const BookAppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Get.back(),
        ),
        title:  Text(
          AppStrings.bookAppointment,
          style: TextStyle(
            color: AppColors.black,
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
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.05),
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
                      color: AppColors.grey600,
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
                  color: AppColors.circularprogressindicator,
                ),
              ),
            );
          }

          if (controller.slots.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.white,
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
                        color: AppColors.grey600,
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
                        ? AppColors.grey200
                        : isSelected
                        ?  AppColors.circularprogressindicator
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: !isAvailable
                          ? AppColors.grey300
                          : isSelected
                          ? AppColors.circularprogressindicator
                          : AppColors.grey300,
                    ),
                  ),
                  child: Text(
                    slot.displayTime,
                    style: TextStyle(
                      color: !isAvailable
                          ? AppColors.grey500
                          : isSelected
                          ? AppColors.white
                          : AppColors.black87,
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
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
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
              backgroundColor:  AppColors.circularprogressindicator,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 0,
            ),
            child:  Text(
              AppStrings.next,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}*/



class BookAppointmentScreen extends GetView<BookAppointmentController> {
  const BookAppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          AppStrings.bookAppointment,
          style: TextStyle(
            color: AppColors.black,
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
                  _buildDateSection(),
                  const SizedBox(height: 24),
                  _buildConsultationDuration(),
                  const SizedBox(height: 24),
                  _buildTimeSection(),
                  const SizedBox(height: 24),
                  _buildAgeField(),
                  const SizedBox(height: 16),
                  _buildGenderField(),
                  const SizedBox(height: 16),
                  _buildIdProofField(),
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

  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.selectDate,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Obx(() => _buildCalendar()),
      ],
    );
  }

  Widget _buildCalendar() {
    final now = DateTime.now();
    final selectedDate = controller.selectedDate.value;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey300),
      ),
      child: Column(
        children: [
          // Month/Year header with navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_getMonthName(controller.displayMonth.value.month)} ${controller.displayMonth.value.year}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, size: 20),
                    onPressed: controller.previousMonth,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.chevron_right, size: 20),
                    onPressed: controller.nextMonth,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Weekday headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                .map((day) => SizedBox(
              width: 36,
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey600,
                  ),
                ),
              ),
            ))
                .toList(),
          ),
          const SizedBox(height: 8),
          // Calendar grid
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final displayMonth = controller.displayMonth.value;
    final selectedDate = controller.selectedDate.value;
    final now = DateTime.now();

    // Get first day of month and calculate offset
    final firstDay = DateTime(displayMonth.year, displayMonth.month, 1);
    final lastDay = DateTime(displayMonth.year, displayMonth.month + 1, 0);
    final startWeekday = firstDay.weekday % 7; // Convert to 0=Sunday

    List<Widget> dayWidgets = [];

    // Add empty cells for days before month starts
    for (int i = 0; i < startWeekday; i++) {
      dayWidgets.add(const SizedBox(width: 36, height: 36));
    }

    // Add day cells
    for (int day = 1; day <= lastDay.day; day++) {
      final date = DateTime(displayMonth.year, displayMonth.month, day);
      final isSelected = selectedDate != null &&
          date.year == selectedDate.year &&
          date.month == selectedDate.month &&
          date.day == selectedDate.day;
      final isPast = date.isBefore(DateTime(now.year, now.month, now.day));

      dayWidgets.add(
        InkWell(
          onTap: isPast ? null : () => controller.onDateSelected(date),
          borderRadius: BorderRadius.circular(18),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.circularprogressindicator
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$day',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isPast
                      ? AppColors.grey400
                      : isSelected
                      ? AppColors.white
                      : AppColors.black87,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: dayWidgets,
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  Widget _buildConsultationDuration() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Consultation Duration',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.grey300),
          ),
          child: Obx(
                () => DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: controller.selectedDuration.value,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, size: 20),
                items: ['10 Minute', '20 Minute'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    controller.selectedDuration.value = newValue;
                  }
                },
                selectedItemBuilder: (BuildContext context) {
                  return ['10 Minute', '20 Minute'].map((String value) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black87,
                        ),
                      ),
                    );
                  }).toList();
                },
                dropdownColor: AppColors.white,
                menuMaxHeight: 200,
              ),
            ),
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
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: CircularProgressIndicator(
                  color: AppColors.circularprogressindicator,
                ),
              ),
            );
          }

          if (controller.slots.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.white,
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
                        color: AppColors.grey600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: controller.slots.length,
            itemBuilder: (context, index) {
              final slot = controller.slots[index];
              final isSelected = controller.selectedSlot.value?.slotId == slot.slotId;
              final isAvailable = slot.isAvailable;

              return InkWell(
                onTap: isAvailable ? () => controller.onSlotSelected(slot) : null,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: !isAvailable
                        ? AppColors.grey200
                        : isSelected
                        ? AppColors.circularprogressindicator
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: !isAvailable
                          ? AppColors.grey300
                          : isSelected
                          ? AppColors.circularprogressindicator
                          : AppColors.grey300,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      slot.displayTime,
                      style: TextStyle(
                        color: !isAvailable
                            ? AppColors.grey500
                            : isSelected
                            ? AppColors.white
                            : AppColors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        decoration: !isAvailable
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildAgeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Age',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.grey300),
          ),
          child: TextField(
            controller: controller.ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter Your Age Here',
              hintStyle: TextStyle(
                color: AppColors.grey400,
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.grey300),
          ),
          child: Obx(
                () => DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: controller.selectedGender.value.isEmpty
                    ? null
                    : controller.selectedGender.value,
                isExpanded: true,
                hint: Text(
                  'Select Your Gender',
                  style: TextStyle(
                    color: AppColors.grey400,
                    fontSize: 14,
                  ),
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                items: ['Male', 'Female', 'Other'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    controller.selectedGender.value = newValue;
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIdProofField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Id Proof',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.grey300),
          ),
          child: Obx(
                () => DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: controller.selectedIdProof.value.isEmpty
                    ? null
                    : controller.selectedIdProof.value,
                isExpanded: true,
                hint: const Text(
                  'Select',
                  style: TextStyle(
                    color: AppColors.grey400,
                    fontSize: 14,
                  ),
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                items: ['Aadhar Card', 'PAN Card', 'Driving License', 'Passport']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    controller.selectedIdProof.value = newValue;
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
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
              backgroundColor: AppColors.circularprogressindicator,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Continue',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}