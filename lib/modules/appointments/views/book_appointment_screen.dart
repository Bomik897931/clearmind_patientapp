
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/textWidget.dart';
import '../controllers/book_appointment_controller.dart';

class BookAppointmentScreen extends GetView<BookAppointmentController> {
  const BookAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double referenceHeight = 800;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(Assets.backIcon, height: 24, width: 24),
          // onPressed: () => print("Back"),
          onPressed: () {
            if (Get.isSnackbarOpen) {
              Get.closeCurrentSnackbar();
            }
            if (Get.key.currentState?.canPop() == true) {
              Navigator.of(Get.context!).pop();
            }
          },
        ),
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            mediumtext(text: AppStrings.bookAppointment, fontsize: 16),
            mediumtext(
              text: "How To Book ?",
              fontsize: 12,
              color: AppColors.primaryLight,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
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
                    patientnameTextField(),
                    const SizedBox(height: 16),
                    ageTextField(),
                    const SizedBox(height: 16),
                    _buildGenderField(),
                    const SizedBox(height: 16),
                    _buildIdProofField(),
                    // const SizedBox(height: 60),
                    //  _buildBottomBar(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mediumtext(text: AppStrings.selectDate, fontsize: 16),
        const SizedBox(height: 16),
        Obx(() => _buildCalendar()),
      ],
    );
  }

  Widget _buildCalendar() {
    final now = DateTime.now();
    final selectedDate = controller.selectedDate.value;

    return Container(
      // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.extraPrimaryLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Month/Year header with navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, size: 20),
                    onPressed: controller.previousMonth,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 40),
                  regulartext(
                    text:
                        '${_getMonthName(controller.displayMonth.value.month)} ${controller.displayMonth.value.year}',
                    fontsize: 16,
                    color: AppColors.textPrimary,
                  ),

                  const SizedBox(width: 40),

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
          const SizedBox(height: 24),
          // Weekday headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                .map(
                  (day) => SizedBox(
                    width: 36,
                    child: Center(
                      child: regulartext(
                        text: day,
                        fontsize: 12,
                        color: AppColors.grey600,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
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
      final isSelected =
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
              child: regulartext(
                text: '$day',
                fontsize: 14,
                color: isPast
                    ? AppColors.black87
                    : isSelected
                    ? AppColors.white
                    : AppColors.black87,
              ),
            ),
          ),
        ),
      );
    }

    return Wrap(spacing: 8, runSpacing: 8, children: dayWidgets);
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  Widget _buildConsultationDuration() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mediumtext(text: 'Consultation Duration', fontsize: 16),
        const SizedBox(height: 21),
        Container(
          height: 28,
          width: 120,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.grey300),
          ),
          child: Obx(
            () => DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: ['10', '20'].contains(controller.selectedDuration.value)
                    ? controller.selectedDuration.value
                    : null,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, size: 20),
                items: ['10', '20'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: mediumtext(text: value, fontsize: 12),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    controller.selectedDuration.value = newValue;
                    controller.loadSlots(controller.selectedDate.value);
                  }
                  print(newValue);
                },
                selectedItemBuilder: (BuildContext context) {
                  return ['10', '20'].map((String value) {
                    return Container(
                      alignment: Alignment.center,
                      child: mediumtext(text: "$value Minute", fontsize: 12),
                    );
                  }).toList();
                },
                dropdownColor: AppColors.extraPrimaryLight,
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
                      style: TextStyle(color: AppColors.grey600, fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Selection count indicator
              Obx(() {
                if (controller.selectedSlots.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 16,
                            color: AppColors.primaryLight,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${controller.selectedSlots.length} slot(s) selected',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),

              // Grid of slots
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 5.6,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 8,
                ),
                itemCount: controller.slots.length,
                itemBuilder: (context, index) {
                  final slot = controller.slots[index];

                  return Obx(() {
                    final isSelected = controller.isSlotSelected(slot);
                    final isAvailable = slot.isAvailable;

                    return InkWell(
                      onTap: isAvailable
                          ? () => controller.onSlotSelected(slot)
                          : null,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 36,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryLight
                              : isAvailable
                              ? AppColors.white
                              : AppColors.grey100,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryLight
                                : isAvailable
                                ? AppColors.primaryLight
                                : AppColors.grey300,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isSelected)
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Icon(
                                  Icons.check_circle,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            Text(
                              slot.displayTime,
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : isAvailable
                                    ? AppColors.primaryLight
                                    : AppColors.grey600,
                                decoration: !isAvailable
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget patientnameTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mediumtext(text: "Patient Full Name*", fontsize: 14),
        const SizedBox(height: 8),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller.patientNameController,
            decoration: InputDecoration(
              fillColor: AppColors.white,
              hintText: "Enter Your Name Here",
              hintStyle: AppTextStyles.bodySmallGrey,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget ageTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mediumtext(text: "Age*", fontsize: 14),

        const SizedBox(height: 8),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            // border: Border.all(color: Colors.grey),
          ),
          child: TextField(
            controller: controller.ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              fillColor: AppColors.white,
              hintText: "Enter Your Age Here",
              hintStyle: AppTextStyles.bodySmallGrey,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
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
        mediumtext(text: "Gender*", fontsize: 14),
        const SizedBox(height: 8),
        Obx(
          () => CommonDropdown(
            value: controller.selectedGender.value.isEmpty
                ? null
                : controller.selectedGender.value,
            hint: 'Select Your Gender',
            items: const ['Male', 'Female', 'Other'],
            onChanged: (String? newValue) {
              if (newValue != null) {
                controller.selectedGender.value = newValue;
              }
            },
          ),
        ),

      ],
    );
  }

  Widget _buildIdProofField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mediumtext(text: "Select Id Proof*", fontsize: 14),
        const SizedBox(height: 8),
        Obx(
          () => CommonDropdown(
            value: controller.selectedIdProof.value.isEmpty
                ? null
                : controller.selectedIdProof.value,
            hint: 'Select',
            // items: ['Aadhar Card', 'PAN Card', 'Driving License', 'Passport'],
            items: controller.identityDocTypes
                .map((e) => e.name)
                .toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                controller.selectedIdProof.value = newValue;
                controller.showIdNumberField.value = true;

                // 👇 hint text logic
                if (newValue == 'PAN') {
                  controller.idNumberHint.value = 'Enter PAN Number';
                } else if (newValue == 'Aadhaar') {
                  controller.idNumberHint.value = 'Enter Aadhaar Number';
                } else if (newValue == 'DrivingLicense') {
                  controller.idNumberHint.value = 'Enter Driving License Number';
                } else if (newValue == 'Passport') {
                  controller.idNumberHint.value = 'Enter Passport Number';
                } else {
                  controller.idNumberHint.value = 'Enter ID Number';
                }

              }
            },
          ),
        ),
        const SizedBox(height: 24),
        // Obx(() => controller.showIdNumberField.value ?

        // ),
        Obx(
          () => controller.showIdNumberField.value
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mediumtext(
                      text: controller.idNumberHint.value,
                      fontsize: 14,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: controller.idNumberController,
                        decoration: InputDecoration(
                          fillColor: AppColors.white,
                          hintText: controller.idNumberHint.value,
                          hintStyle: AppTextStyles.bodySmallGrey,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: controller.bookAppointment,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 11, horizontal: 112),
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(child: Text("Continue", style: AppTextStyles.button)),
        ),
      ),
    );
  }
}
