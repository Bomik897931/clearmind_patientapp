import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle h1 = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    fontFamily: 'Quicksand',
    height: 1.2,
  );

  static TextStyle h2 = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    fontFamily: 'Quicksand',
    height: 1.2,
  );

  static TextStyle h3 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'Quicksand',
    height: 1.3,
  );
  static TextStyle heading51 = TextStyle(
    fontSize: 14.sp, // ✅ 14px
    fontWeight: FontWeight.w500, // ✅ Medium (500)
    fontFamily: 'Quicksand', // ✅ EB Garamond
    color: AppColors.white,
    height: 21 / 14, // ✅ line-height: 21px
    letterSpacing: -0.011 * 14, // ✅ -1.1%
  );
  static TextStyle subHeading = TextStyle(
    fontSize: 24.sp, // ✅ 24px
    fontWeight: FontWeight.w500, // ✅ Medium
    fontFamily: 'Quicksand', // ✅ Font
    color: AppColors.white,
    height: 31.2 / 24, // ✅ line-height
    letterSpacing: -0.011 * 24, // ✅ -1.1%
  );
  static TextStyle heading5 = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.5, // 21px line-height
    letterSpacing: -0.15,
    color: AppColors.textPrimary,
  );
  static TextStyle heading5_2 = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.5, // 21px line height
    letterSpacing: -0.15, // -1.1%
    color: AppColors.textPrimary,
  );

  static TextStyle heading5_1 = TextStyle(
    fontFamily: 'Quicksand',
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.5, // 21px line height
    letterSpacing: -0.15, // -1.1%
    color: const Color(0xFF3F3F47),
  );

  static TextStyle h4 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'Quicksand',
    height: 1.3,
  );

  static TextStyle h5 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'Quicksand',
    height: 1.4,
  );

  static TextStyle h6 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'Quicksand',
    height: 1.4,
  );

  static TextStyle bodyLarge = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    fontFamily: 'Quicksand',
    height: 1.5,
  );

  static TextStyle bodyMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    fontFamily: 'Quicksand',
    height: 1.5,
  );

  static TextStyle bodySmall = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    fontFamily: 'Quicksand',
    height: 1.5,
  );

  static TextStyle bodySmallGrey = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.grey300,
    fontFamily: 'Quicksand',
    height: 1.5,
  );

  static TextStyle button = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    fontFamily: 'Quicksand',
    height: 1.2,
  );

  static TextStyle caption = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    fontFamily: 'Quicksand',
    height: 1.4,
  );
}
