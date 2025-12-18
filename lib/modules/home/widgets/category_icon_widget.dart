// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:patient_app/core/constants/app_text_style.dart';
// import '../../../core/constants/app_colors.dart';
// import '../../../core/constants/app_dimensions.dart';
// import '../../../data/models/category_model.dart';
//
// class CategoryIconWidget extends StatelessWidget {
//   final Specialization category;
//   final VoidCallback onTap;
//
//   const CategoryIconWidget({
//     Key? key,
//     required this.category,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 70.w,
//             height: 70.w,
//             decoration: BoxDecoration(
//               color: AppColors.white,
//               borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
//             ),
//             child: Icon(
//               _getCategoryIcon(category.specializationName),
//               color: AppColors.primary,
//               size: AppDimensions.iconLG,
//             ),
//           ),
//           SizedBox(height: AppDimensions.paddingSM),
//           SizedBox(
//             width: 70.w,
//             child: Text(
//               category.specializationName,
//               style: AppTextStyles.caption.copyWith(
//                 color: AppColors.textPrimary,
//                 fontWeight: FontWeight.w500,
//               ),
//               textAlign: TextAlign.center,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   IconData _getCategoryIcon(String name) {
//     switch (name.toLowerCase()) {
//       case 'general':
//         return Icons.local_hospital;
//       case 'cardiologist':
//         return Icons.favorite;
//       case 'dentist':
//         return Icons.medical_services;
//       case 'more':
//         return Icons.grid_view;
//       case 'dermatologist':
//         return Icons.face;
//       case 'pediatrician':
//         return Icons.child_care;
//       case 'gynecologist':
//         return Icons.pregnant_woman;
//       case 'nutritionist':
//         return Icons.restaurant;
//       case 'endocrinologist':
//         return Icons.science;
//       case 'psychiatrist':
//         return Icons.psychology;
//       case 'hematologist':
//         return Icons.bloodtype;
//       case 'ophthalmologist':
//         return Icons.remove_red_eye;
//       case 'oncologist':
//         return Icons.healing;
//       case 'orthopedic':
//         return Icons.accessibility_new;
//       case 'urologist':
//         return Icons.water_drop;
//       case 'neurologist':
//         return Icons.branding_watermark;
//       default:
//         return Icons.medical_services;
//     }
//   }
// }

// lib/modules/home/widgets/category_icon_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../data/models/category_model.dart';

class CategoryIconWidget extends StatelessWidget {
  final Specialization specialization;
  final VoidCallback onTap;

  const CategoryIconWidget({
    Key? key,
    required this.specialization,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              specialization.icon,
              color: AppColors.primary,
              size: 28.w,
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: 70.w,
            child: Text(
              specialization.specializationName,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
