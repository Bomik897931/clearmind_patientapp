import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/constants/app_text_style.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../controllers/appointment_detail_controller.dart';

class AppointmentDetailScreen extends GetView<AppointmentDetailController> {
  const AppointmentDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: const CustomAppBar(title: 'My Appointment'),
      body: Obx(() {
        final appointment = controller.appointment.value;
        if (appointment == null) {
          return const Center(child: Text('No appointment data'));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(AppDimensions.paddingMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDoctorCard(appointment),
              SizedBox(height: AppDimensions.paddingLG),
              _buildScheduledAppointment(appointment),
              SizedBox(height: AppDimensions.paddingLG),
              _buildPatientInformation(),
              SizedBox(height: AppDimensions.paddingLG),
              _buildYourPackage(),
              SizedBox(height: AppDimensions.paddingXL),
              CustomButton(
                text: 'Message (Start at 05:30 PM)',
                onPressed: controller.onStartMessaging,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDoctorCard(appointment) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      ),
      child: Row(
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: AppColors.grey100,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            ),
            child: Icon(
              Icons.person,
              size: AppDimensions.iconXL,
              color: AppColors.textTertiary,
            ),
          ),
          SizedBox(width: AppDimensions.paddingMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appointment.doctor.name, style: AppTextStyles.h6),
                SizedBox(height: 4.h),
                Text(
                  appointment.doctor.specialty,
                  style: AppTextStyles.bodySmall,
                ),
                SizedBox(height: 4.h),
                Text(
                  appointment.doctor.hospital,
                  style: AppTextStyles.caption,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduledAppointment(appointment) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Scheduled Appointment', style: AppTextStyles.h6),
          SizedBox(height: AppDimensions.paddingMD),
          _buildInfoRow('Today | December 22, 2022'),
          _buildInfoRow('05 - 05:30 PM (30 minutes)'),
        ],
      ),
    );
  }

  Widget _buildPatientInformation() {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Patient information', style: AppTextStyles.h6),
          SizedBox(height: AppDimensions.paddingMD),
          _buildInfoRow('Full Name : Andrew Ainsley'),
          _buildInfoRow('Gender : Male'),
          _buildInfoRow('Age : 25'),
          _buildInfoRow('Problem : lorem ipsum dolor sit amet'),
        ],
      ),
    );
  }

  Widget _buildYourPackage() {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your Package', style: AppTextStyles.h6),
          SizedBox(height: AppDimensions.paddingMD),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppDimensions.paddingSM),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                ),
                child: Icon(
                  Icons.message,
                  color: AppColors.primary,
                  size: AppDimensions.iconMD,
                ),
              ),
              SizedBox(width: AppDimensions.paddingMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Messaging',
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Chat messages with doctor',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
              Text(
                '\$20',
                style: AppTextStyles.h6.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 50.w),
            child: Text('30 min', style: AppTextStyles.caption),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.paddingSM),
      child: Text(
        text,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
