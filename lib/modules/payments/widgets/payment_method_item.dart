import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/constants/app_text_style.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

class PaymentMethodItem extends StatelessWidget {
  final IconData icon;
  final String name;
  final String value;
  final String selectedValue;
  final Function(String) onChanged;

  const PaymentMethodItem({
    Key? key,
    required this.icon,
    required this.name,
    required this.value,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = value == selectedValue;

    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      child: Container(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: AppDimensions.iconMD,
              ),
            ),
            SizedBox(width: AppDimensions.paddingMD),
            Expanded(
              child: Text(
                name,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Radio<String>(
              value: value,
              groupValue: selectedValue,
              onChanged: (val) {
                if (val != null) {
                  onChanged(val);
                }
              },
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
