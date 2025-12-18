import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/constants/app_text_style.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showArrow;

  const ProfileMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.iconColor,
    this.onTap,
    this.trailing,
    this.showArrow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      child: Container(
        margin: EdgeInsets.only(bottom: AppDimensions.paddingMD),
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppDimensions.paddingSM),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
              ),
              child: Icon(icon, color: iconColor, size: AppDimensions.iconMD),
            ),
            SizedBox(width: AppDimensions.paddingMD),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            trailing ??
                (showArrow
                    ? const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: AppColors.textTertiary,
                      )
                    : const SizedBox()),
          ],
        ),
      ),
    );
  }
}
