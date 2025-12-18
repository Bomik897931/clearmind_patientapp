import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/constants/app_text_style.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../data/models/category_model.dart';

class CategoryGridItem extends StatelessWidget {
  final Specialization category;
  final VoidCallback onTap;

  const CategoryGridItem({
    Key? key,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      child: Container(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getCategoryIcon(category.specializationName),
                color: AppColors.primary,
                size: AppDimensions.iconLG,
              ),
            ),
            SizedBox(height: AppDimensions.paddingSM),
            Text(
              category.specializationName,
              style: AppTextStyles.caption.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String name) {
    switch (name.toLowerCase()) {
      case 'general':
        return Icons.local_hospital;
      case 'cardiologist':
        return Icons.favorite;
      case 'dentist':
        return Icons.medical_services;
      case 'dermatologist':
        return Icons.face;
      case 'pediatrician':
        return Icons.child_care;
      case 'gynecologist':
        return Icons.pregnant_woman;
      case 'nutritionist':
        return Icons.restaurant;
      case 'endocrinologist':
        return Icons.science;
      case 'psychiatrist':
        return Icons.psychology;
      case 'hematologist':
        return Icons.bloodtype;
      case 'ophthalmologist':
        return Icons.remove_red_eye;
      case 'oncologist':
        return Icons.healing;
      case 'orthopedic':
        return Icons.accessibility_new;
      case 'urologist':
        return Icons.water_drop;
      case 'neurologist':
        return Icons.branding_watermark;
      default:
        return Icons.medical_services;
    }
  }
}
