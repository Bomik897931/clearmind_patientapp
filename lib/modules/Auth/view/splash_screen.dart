// lib/modules/splash/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_style.dart';
import '../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget{
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final splashController = Get.find<SplashController>();
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo/Icon
            Icon(
              Icons.local_hospital,
              size: 100.w,
              color: AppColors.white,
            ),
            SizedBox(height: 24.h),

            // App Name
            Text(
              'Patient App',
              style: AppTextStyles.h2.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),

            // Tagline
            Text(
              'Your Health, Our Priority',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.white.withOpacity(0.9),
              ),
            ),
            SizedBox(height: 48.h),

            // Loading Indicator
            // CircularProgressIndicator(
            //   valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
            // ),
          ],
        ),
      ),
    );
  }
}