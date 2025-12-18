import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle h1 = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
    height: 1.2,
  );

  static TextStyle h2 = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
    height: 1.2,
  );

  static TextStyle h3 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
    height: 1.3,
  );

  static TextStyle h4 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
    height: 1.3,
  );

  static TextStyle h5 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
    height: 1.4,
  );

  static TextStyle h6 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
    height: 1.4,
  );

  static TextStyle bodyLarge = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
    height: 1.5,
  );

  static TextStyle bodyMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
    height: 1.5,
  );

  static TextStyle bodySmall = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    fontFamily: 'Inter',
    height: 1.5,
  );

  static TextStyle button = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: 'Inter',
    height: 1.2,
  );

  static TextStyle caption = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    fontFamily: 'Inter',
    height: 1.4,
  );
}
