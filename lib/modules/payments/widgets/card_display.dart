import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/constants/app_text_style.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

class CardDisplay extends StatelessWidget {
  final String balance;
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;

  const CardDisplay({
    Key? key,
    required this.balance,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppDimensions.paddingLG),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Balance',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.white.withOpacity(0.8),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingSM,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                ),
                child: Text(
                  'VISA',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.paddingSM),
          Text(
            balance,
            style: AppTextStyles.h2.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: AppDimensions.paddingLG),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardNumber,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.white,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.paddingMD),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardHolder,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.white,
                ),
              ),
              Text(
                expiryDate,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
