import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/constants/app_text_style.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../data/models/doctor_model.dart';

class DoctorCardWidget extends StatelessWidget {
  final DoctorModel doctor;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const DoctorCardWidget({
    Key? key,
    required this.doctor,
    required this.onTap,
    required this.onFavorite,
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
        child: Row(
          children: [
            // Doctor Image
            // Container(
            //   width: 80.w,
            //   height: 80.w,
            //   decoration: BoxDecoration(
            //     color: AppColors.grey100,
            //     borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            //     // image: doctor.image.isNotEmpty
            //     //     ? DecorationImage(
            //     //         image: NetworkImage(doctor.image),
            //     //         fit: BoxFit.cover,
            //     //       )
            //     //     :
            //     // null,
            //   ),
            //   child:
            //   // doctor.image.isEmpty
            //   //     ?
            //   Icon(
            //           Icons.person,
            //           size: AppDimensions.iconXL,
            //           color: AppColors.textTertiary,
            //         )
            //       // : null,
            // ),
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
            // Doctor Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          doctor.firstName,
                          style: AppTextStyles.h6,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // InkWell(
                      //   onTap: onFavorite,
                      //   child: Icon(
                      //     doctor.isFavorite
                      //         ? Icons.favorite
                      //         : Icons.favorite_border,
                      //     color: doctor.isFavorite
                      //         ? AppColors.error
                      //         : AppColors.textTertiary,
                      //     size: AppDimensions.iconMD,
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: AppDimensions.paddingXS),
                  Text(
                    doctor.specialty,
                    style: AppTextStyles.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppDimensions.paddingXS),
                  // Row(
                  //   children: [
                  //     Icon(Icons.star, color: AppColors.rating, size: 16.w),
                  //     SizedBox(width: 4.w),
                  //     Text(
                  //       '${doctor.} (${doctor.reviewCount} reviews)',
                  //       style: AppTextStyles.caption,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
