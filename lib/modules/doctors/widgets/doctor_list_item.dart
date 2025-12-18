// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:patient_app/core/constants/app_text_style.dart';
// import '../../../core/constants/app_colors.dart';
// import '../../../core/constants/app_dimensions.dart';
// import '../../../data/models/doctor_model.dart';
//
// class DoctorListItem extends StatelessWidget {
//   final DoctorModel doctor;
//   final VoidCallback onTap;
//   final VoidCallback onFavorite;
//
//   const DoctorListItem({
//     Key? key,
//     required this.doctor,
//     required this.onTap,
//     required this.onFavorite,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//       child: Container(
//         padding: EdgeInsets.all(AppDimensions.paddingMD),
//         decoration: BoxDecoration(
//           color: AppColors.white,
//           borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.shadowLight,
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 80.w,
//               height: 80.w,
//               decoration: BoxDecoration(
//                 color: AppColors.grey100,
//                 borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//               ),
//               child: Icon(
//                 Icons.person,
//                 size: AppDimensions.iconXL,
//                 color: AppColors.textTertiary,
//               ),
//             ),
//             SizedBox(width: AppDimensions.paddingMD),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           doctor.name,
//                           style: AppTextStyles.h6,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       InkWell(
//                         onTap: onFavorite,
//                         child: Icon(
//                           doctor.isFavorite
//                               ? Icons.favorite
//                               : Icons.favorite_border,
//                           color: doctor.isFavorite
//                               ? AppColors.error
//                               : AppColors.textTertiary,
//                           size: AppDimensions.iconMD,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: AppDimensions.paddingXS),
//                   Text(
//                     '${doctor.specialty} | ${doctor.hospital}',
//                     style: AppTextStyles.bodySmall,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   SizedBox(height: AppDimensions.paddingSM),
//                   Row(
//                     children: [
//                       Icon(Icons.star, color: AppColors.rating, size: 16.w),
//                       SizedBox(width: 4.w),
//                       Text(
//                         '${doctor.rating} (${doctor.reviewCount} reviews)',
//                         style: AppTextStyles.caption,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// lib/modules/doctors/widgets/doctor_list_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:patient_app/data/models/doctor_model.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../controllers/top_doctors_controller.dart';

class DoctorListItem extends StatelessWidget {
  final DoctorModel doctor;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const DoctorListItem({
    Key? key,
    required this.doctor,
    required this.onTap,
    required this.onFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<TopDoctorsController>();

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
        child: Row(
          children: [
            // Doctor Avatar
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
              ),
              child: Center(
                child: Text(
                  doctor.firstName[0].toUpperCase(),
                  style: AppTextStyles.h3.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: AppDimensions.paddingMD),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          doctor.fullName,
                          style: AppTextStyles.h6,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Obx(() => InkWell(
                      //   onTap: onFavorite,
                      //   child: Icon(
                      //     controller.isFavorite(doctor)
                      //         ? Icons.favorite
                      //         : Icons.favorite_border,
                      //     color: controller.isFavorite(doctor)
                      //         ? AppColors.error
                      //         : AppColors.textTertiary,
                      //     size: AppDimensions.iconMD,
                      //   ),
                      // )),
                    ],
                  ),
                  SizedBox(height: AppDimensions.paddingXS),
                  Text(
                    '${doctor.specialty} | ${doctor.education}',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppDimensions.paddingXS),
                  Text(
                    _formatAddress(doctor.address),
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textTertiary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppDimensions.paddingSM),
                  Row(
                    children: [
                      Icon(Icons.work_outline, color: AppColors.textSecondary, size: 14.w),
                      SizedBox(width: 4.w),
                      Text(
                        '${doctor.experienceYears} years exp',
                        style: AppTextStyles.caption,
                      ),
                      SizedBox(width: 12.w),
                      Icon(Icons.currency_rupee, color: AppColors.primary, size: 14.w),
                      Text(
                        '${doctor.fees.toStringAsFixed(0)}',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatAddress(String address) {
    final parts = address.split(',');
    if (parts.length >= 2) {
      return '${parts[parts.length - 2].trim()}, ${parts[parts.length - 1].trim()}';
    }
    return address;
  }
}
