// lib/modules/slots/screens/slots_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../data/models/slot_model.dart';
import '../../../widgets/loading_widget.dart';
import '../controller/slot_controller.dart';

class SlotsScreen extends GetView<SlotsController> {
  const SlotsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text('Select Slot', style: AppTextStyles.h5),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.slots.isEmpty) {
          return const LoadingWidget();
        }

        return Column(
          children: [
            // Info Banner
            Container(
              padding: EdgeInsets.all(AppDimensions.paddingMD),
              color: AppColors.primary.withOpacity(0.1),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.primary, size: 20.w),
                  SizedBox(width: AppDimensions.paddingSM),
                  Expanded(
                    child: Text(
                      '${controller.totalCount.value} slots available',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Slots List
            Expanded(
              child:
              controller.slots.isEmpty
                  ?
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.event_busy,
                      size: 64.w,
                      color: AppColors.textTertiary,
                    ),
                    SizedBox(height: AppDimensions.paddingMD),
                    Text(
                      'No slots available',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              )
                  : RefreshIndicator(
                onRefresh: controller.refresh,
                child: ListView.separated(
                  padding: EdgeInsets.all(AppDimensions.paddingMD),
                  itemCount: controller.slots.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(height: AppDimensions.paddingSM),
                  itemBuilder: (context, index) {
                    final slot = controller.slots[index];
                    return _buildSlotCard(slot);
                  },
                ),
              ),
            ),

            // Pagination
            if (controller.totalPages.value > 1)
              _buildPaginationControls(),

            // Selected Slot Info & Book Button
            Obx(() {
              if (controller.selectedSlot.value == null) {
                return const SizedBox();
              }

              return _buildBookingSection();
            }),
          ],
        );
      }),
    );
  }

  Widget _buildSlotCard(Slot slot) {
    return Obx(() {
      final isSelected = controller.selectedSlot.value?.slotId == slot.slotId;

      return InkWell(
        onTap: () => controller.selectSlot(slot),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        child: Container(
          padding: EdgeInsets.all(AppDimensions.paddingMD),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withOpacity(0.1)
                : AppColors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : slot.isAvailable
                  ? AppColors.grey300
                  : Colors.red.withOpacity(0.3),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: slot.isAvailable
                      ? AppColors.primary.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                ),
                child: Icon(
                  Icons.access_time,
                  color: slot.isAvailable ? AppColors.primary : Colors.grey,
                  size: 24.w,
                ),
              ),

              SizedBox(width: AppDimensions.paddingMD),

              // Slot Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      slot.doctorName,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 14.w, color: AppColors.textSecondary),
                        SizedBox(width: 4.w),
                        // Text(
                        //   slot.formattedDate,
                        //   style: AppTextStyles.bodySmall.copyWith(
                        //     color: AppColors.textSecondary,
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.schedule,
                            size: 14.w, color: AppColors.textSecondary),
                        SizedBox(width: 4.w),
                        // Text(
                        //   slot.formattedTime,
                        //   style: AppTextStyles.bodySmall.copyWith(
                        //     color: AppColors.textSecondary,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),

              // Status Badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingSM,
                  vertical: AppDimensions.paddingXS,
                ),
                decoration: BoxDecoration(
                  color: slot.isAvailable
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                ),
                child: Text(
                  slot.isAvailable ? 'Available' : 'Booked',
                  style: AppTextStyles.caption.copyWith(
                    color: slot.isAvailable ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Selected Icon
              if (isSelected)
                Padding(
                  padding: EdgeInsets.only(left: AppDimensions.paddingXS),
                  child: Icon(
                    Icons.check_circle,
                    color: AppColors.primary,
                    size: 24.w,
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildPaginationControls() {
    return Obx(() => Container(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.paddingSM),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
            onPressed: controller.hasPrevious.value
                ? controller.previousPage
                : null,
            icon: const Icon(Icons.arrow_back),
            label: const Text('Previous'),
          ),
          Text(
            'Page ${controller.currentPage.value} of ${controller.totalPages.value}',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          TextButton.icon(
            onPressed: controller.hasNext.value ? controller.nextPage : null,
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Next'),
            style: TextButton.styleFrom(
              iconAlignment: IconAlignment.end,
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildBookingSection() {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Appointment Details',
              style: AppTextStyles.h6.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppDimensions.paddingSM),

            // Reason Field
            TextField(
              controller: controller.reasonController,
              decoration: InputDecoration(
                labelText: 'Reason for appointment *',
                hintText: 'e.g., Regular checkup, Consultation',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                ),
                prefixIcon: const Icon(Icons.medical_services),
              ),
            ),
            SizedBox(height: AppDimensions.paddingSM),

            // Notes Field
            TextField(
              controller: controller.notesController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Additional notes (optional)',
                hintText: 'Any specific concerns or information',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                ),
                prefixIcon: const Icon(Icons.note),
              ),
            ),
            SizedBox(height: AppDimensions.paddingMD),

            // Book Button
            Obx(() => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.isBooking.value
                    ? null
                    : controller.bookAppointment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(AppDimensions.radiusMD),
                  ),
                ),
                child: controller.isBooking.value
                    ? SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    : Text(
                  'Book Appointment',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}