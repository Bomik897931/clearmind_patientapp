// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:patient_app/core/constants/app_text_style.dart';
// import '../../../core/constants/app_colors.dart';
// import '../../../core/constants/app_dimensions.dart';
// import '../../../core/constants/app_strings.dart';

// class SearchBarWidget extends StatelessWidget {
//   final Function(String) onChanged;

//   const SearchBarWidget({Key? key, required this.onChanged}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: AppDimensions.paddingMD,
//         vertical: AppDimensions.paddingSM,
//       ),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.shadowLight,
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Icon(
//             Icons.search,
//             color: AppColors.textTertiary,
//             size: AppDimensions.iconMD,
//           ),
//           SizedBox(width: AppDimensions.paddingMD),
//           Expanded(
//             child: TextField(
//               onChanged: onChanged,
//               style: AppTextStyles.bodyMedium,
//               decoration: InputDecoration(
//                 hintText: AppStrings.searchSpecialist,
//                 hintStyle: AppTextStyles.bodyMedium.copyWith(
//                   color: AppColors.textTertiary,
//                 ),
//                 border: InputBorder.none,
//                 isDense: true,
//                 contentPadding: EdgeInsets.zero,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_dimensions.dart';
import '../controller/home_controller.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String) onChanged;

  const SearchBarWidget({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Container(
      height: 44, // matches your image height
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
      ),
      child: TextField(
        controller: controller.searchController,
        onChanged: onChanged,
        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: "Search Specialist/City",
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textTertiary,
          ),
          border: InputBorder.none,
          prefixIconConstraints: const BoxConstraints(minWidth: 0),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.textTertiary,
          ),
          suffixIcon: Obx(() {
            if (controller.searchQuery.value.isEmpty) {
              return const SizedBox();
            }
            return IconButton(
              icon: Icon(
                Icons.clear,
                color: AppColors.textTertiary,
              ),
              onPressed: controller.clearSearch,
            );
          }),
          // suffixIcon: Padding(
          //   padding: const EdgeInsets.only(right: 12),
          //   child: Icon(Icons.search, color: Colors.grey, size: 22),
          // ),
          suffixIconConstraints: const BoxConstraints(minWidth: 40),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
