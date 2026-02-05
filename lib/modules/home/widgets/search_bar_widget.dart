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
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_style.dart';
import '../controller/home_controller.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String) onChanged;

  const SearchBarWidget({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    const double referenceHeight = 800;
    final controller = Get.find<HomeController>();
    return Container(
      height: screenHeight * 37 / referenceHeight,
      decoration: BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextField(
        controller: controller.searchController,
        onChanged: onChanged,
        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          hintText: "Search",
          hintStyle: AppTextStyles.bodySmallGrey,
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(Assets.searchIcon, height: 16, width: 16),
          ),
          suffixIcon: Obx(() {
            if (controller.searchQuery.value.isEmpty) {
              return const SizedBox();
            }
            return IconButton(
              icon: Icon(Icons.clear, color: AppColors.textTertiary),
              onPressed: controller.clearSearch,
            );
          }),

          suffixIconConstraints: const BoxConstraints(minWidth: 40),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
      ),
    );
  }
}
