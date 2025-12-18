import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/constants/app_text_style.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../widgets/custom_button.dart';
import '../controllers/consultation_end_controller.dart';

class ConsultationEndScreen extends GetView<ConsultationEndController> {
  const ConsultationEndScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.paddingLG),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 60.w,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: AppDimensions.paddingLG),
              Text(
                'The consultation session has ended.',
                style: AppTextStyles.h5,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimensions.paddingSM),
              Text(
                'Recordings have been saved in activity',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimensions.paddingXL),
              Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  size: 50.w,
                  color: AppColors.textTertiary,
                ),
              ),
              SizedBox(height: AppDimensions.paddingMD),
              Text('Dr. Marvin Boeson', style: AppTextStyles.h6),
              Text(
                'Cardiologist',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                'The Valley Hospital in Callsmas, US',
                style: AppTextStyles.caption,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimensions.paddingXL),
              CustomButton(
                text: 'Back to Home',
                onPressed: controller.onBackToHome,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
