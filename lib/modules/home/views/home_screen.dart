// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:patient_app/core/constants/app_text_style.dart';
// import 'package:patient_app/data/models/category_model.dart';
// import 'package:patient_app/modules/home/controller/home_controller.dart';
// import '../../../core/constants/app_colors.dart';
// import '../../../core/constants/app_dimensions.dart';
// import '../../../core/constants/app_strings.dart';
// import '../../../widgets/bottom_nav_bar.dart';
// import '../../../widgets/loading_widget.dart';
// import '../widgets/search_bar_widget.dart';
// import '../widgets/category_icon_widget.dart';
// import '../widgets/doctor_card_widget.dart';

// class HomeScreen extends GetView<HomeController> {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.scaffoldBackground,
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const LoadingWidget();
//         }

//         return SafeArea(
//           child: Column(
//             children: [
//               _buildHeader(controller.categories.first),
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: AppDimensions.paddingMD,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: AppDimensions.paddingLG),
//                       SearchBarWidget(onChanged: controller.onSearchChanged),
//                       SizedBox(height: AppDimensions.paddingLG),
//                       _buildCategoriesSection(),
//                       SizedBox(height: AppDimensions.paddingLG),
//                       _buildTopDoctorsSection(),
//                       SizedBox(height: AppDimensions.paddingXL),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//       bottomNavigationBar: Obx(
//         () => BottomNavBar(currentIndex: controller.selectedBottomIndex.value),
//       ),
//     );
//   }

//   Widget _buildHeader(CategoryModel first) {
//     return Container(
//       padding: EdgeInsets.all(AppDimensions.paddingMD),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [AppColors.primary, AppColors.primaryLight],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(AppDimensions.radiusXL),
//           bottomRight: Radius.circular(AppDimensions.radiusXL),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Icon(
//                 Icons.medical_services,
//                 color: AppColors.white,
//                 size: AppDimensions.iconLG,
//               ),

//               SizedBox(height: AppDimensions.paddingSM),
//               Text(
//                 first.name,
//                 style: AppTextStyles.caption.copyWith(
//                   color: AppColors.textPrimary,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategoriesSection() {
//     return Obx(
//       () => Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: controller.categories
//             .map(
//               (category) => CategoryIconWidget(
//                 category: category,
//                 onTap: () => controller.onCategoryTap(category),
//               ),
//             )
//             .toList(),
//       ),
//     );
//   }

//   Widget _buildTopDoctorsSection() {
//     return Obx(
//       () => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(AppStrings.topDoctors, style: AppTextStyles.h5),
//               TextButton(
//                 onPressed: () => Get.toNamed('/top-doctors'),
//                 child: Text(
//                   AppStrings.seeAll,
//                   style: AppTextStyles.bodyMedium.copyWith(
//                     color: AppColors.primary,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: AppDimensions.paddingMD),
//           ListView.separated(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: controller.topDoctors.length,
//             separatorBuilder: (context, index) =>
//                 SizedBox(height: AppDimensions.paddingMD),
//             itemBuilder: (context, index) {
//               final doctor = controller.topDoctors[index];
//               return DoctorCardWidget(
//                 doctor: doctor,
//                 onTap: () => controller.onDoctorTap(doctor),
//                 onFavorite: () => controller.toggleFavorite(doctor),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

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
//       default:
//         return Icons.medical_services;
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/constants/app_text_style.dart';
import 'package:patient_app/data/models/category_model.dart';
import 'package:patient_app/modules/home/controller/home_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/constant.dart';
import '../../../widgets/bottom_nav_bar.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/textWidget.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/category_icon_widget.dart';
import '../widgets/doctor_card_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingWidget();
        }

        return SafeArea(
          child: Column(
            children: [
              _buildHeaderSection(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingMD,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppDimensions.paddingLG),
                      _buildTopDoctorsSection(),
                      SizedBox(height: AppDimensions.paddingXL),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: Obx(
        () => BottomNavBar(currentIndex: controller.selectedBottomIndex.value),
      ),
    );
  }

  /// ==============================
  /// HEADER SECTION (GREEN AREA)
  /// ==============================
  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppDimensions.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppDimensions.radiusXL),
          bottomRight: Radius.circular(AppDimensions.radiusXL),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top app icon / notification row (optional)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.local_hospital,
                color: AppColors.white,
                size: AppDimensions.iconXL,
              ),
              // Icon(
              //   Icons.notifications_none,
              //   color: AppColors.white,
              //   size: AppDimensions.iconLG,
              // ),
            ],
          ),

          SizedBox(height: AppDimensions.paddingMD),

          // Header title
          GestureDetector(
            onTap: (){
              Get.toNamed('/language');
            },
            child: Text(
              "Let’s find a doctor",
              style: AppTextStyles.h4.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          SizedBox(height: AppDimensions.paddingMD),

          // Search bar inside green area
          SearchBarWidget(
            onChanged: controller.onSearchChanged,
            // hintText: "Search Specialist/City",
            // backgroundColor: AppColors.white,
            // iconColor: AppColors.primary,
          ),


          SizedBox(height: AppDimensions.paddingLG),

          // Categories row
          _buildCategoriesSection(),
        ],
      ),
    );
  }

  /// ==============================
  /// CATEGORIES SECTION
  /// ==============================
  Widget _buildCategoriesSection() {
    return Obx(
          () {
        if (controller.specializations.isEmpty) {
          return const SizedBox();
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: controller.specializations
                .map(
                  (specialization) => Padding(
                padding: EdgeInsets.only(right: AppDimensions.paddingSM),
                child: CategoryIconWidget(
                  specialization: specialization,
                  onTap: () => controller.onSpecializationTap(specialization),
                ),
              ),
            )
                .toList(),
          ),
        );
      },
    );
  }
  // Widget _buildCategoriesSection() {
  //   return Obx(
  //     () => Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: controller.categories
  //           .map(
  //             (category) => CategoryIconWidget(
  //               category: category,
  //               onTap: () => controller.onCategoryTap(category),
  //             ),
  //           )
  //           .toList(),
  //     ),
  //   );
  // }

  /// ==============================
  /// TOP DOCTORS SECTION
  /// ==============================
///
  Widget _buildTopDoctorsSection() {
    return Obx(() {
      // Show empty state
      if (controller.doctors.isEmpty && !controller.isSearching.value) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 48.h),
            child: Column(
              children: [
                Icon(
                  controller.searchQuery.value.isEmpty
                      ? Icons.medical_services_outlined
                      : Icons.search_off,
                  size: 64.w,
                  color: AppColors.textTertiary,
                ),
                SizedBox(height: AppDimensions.paddingMD),
                Text(
                  controller.searchQuery.value.isEmpty
                      ? 'No doctors available'
                      : 'No results found for\n"${controller.searchQuery.value}"',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                if (controller.searchQuery.value.isNotEmpty) ...[
                  SizedBox(height: AppDimensions.paddingSM),
                  TextButton(
                    onPressed: controller.clearSearch,
                    child: Text(
                      'Clear Search',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.searchQuery.value.isEmpty
                    ? AppStrings.topDoctors
                    : 'Search Results',
                style: AppTextStyles.h5.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(
            height: height - 421,
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.doctors.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () => controller.onDoctorTap(controller.doctors[index]),
                // onTap: () => controller.onDoctorTap(doctor[index]),
                contentPadding: const EdgeInsets.all(0),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                    ),
                    child: Center(
                      child: Text(
                        controller.doctors[index].firstName[0].toUpperCase(),
                        style: AppTextStyles.h3.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Image.asset(
                  //   controller.doctors[index]['icon'],
                  //   height: 50,
                  //   width: 50,
                  //   fit: BoxFit.cover,
                  // ),
                ),
                title: mediumtext(
                    text: controller.doctors[index].firstName,
                    fontsize: 15),
                subtitle: regulartext(
                    text: controller.doctors[index].email,
                    fontsize: 12,
                    color: AppColors.hinttextcolor),
                trailing: SizedBox(
                  width: Get.width * .15,
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.golden,
                      ),
                      mediumtext(
                          text: controller.doctors[index].rating,
                          fontsize: 15)
                    ],
                  ),
                ),
              ),
            ),
          ),
          //
          // SizedBox(height: AppDimensions.paddingSM),
          //
          // // Doctor list (will show previous results while searching)
          // ListView.separated(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemCount: controller.doctors.length,
          //   separatorBuilder: (context, index) =>
          //       SizedBox(height: AppDimensions.paddingMD),
          //   itemBuilder: (context, index) {
          //     final doctor = controller.doctors[index];
          //     return DoctorCardWidget(
          //       doctor: doctor,
          //       onTap: () => controller.onDoctorTap(doctor),
          //       onFavorite: () {},
          //     );
          //   },
          // ),

          // Pagination controls
          if (controller.totalPages.value > 1) ...[
            SizedBox(height: AppDimensions.paddingLG),
            // _buildPaginationControls(),
          ],
        ],
      );
    });
  }
  // Widget _buildTopDoctorsSection() {
  //   return Obx(
  //     () => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         // Header row
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               AppStrings.topDoctors,
  //               style: AppTextStyles.h5.copyWith(
  //                 fontWeight: FontWeight.w700,
  //                 color: AppColors.textPrimary,
  //               ),
  //             ),
  //             // TextButton(
  //             //   onPressed: () => Get.toNamed('/top-doctors'),
  //             //   child: Text(
  //             //     AppStrings.seeAll,
  //             //     style: AppTextStyles.bodyMedium.copyWith(
  //             //       color: AppColors.primary,
  //             //       fontWeight: FontWeight.w600,
  //             //     ),
  //             //   ),
  //             // ),
  //           ],
  //         ),
  //         // Add search result count (optional)
  //         Obx(() {
  //           if (controller.searchQuery.value.isNotEmpty) {
  //             return Padding(
  //               padding: EdgeInsets.symmetric(
  //                 horizontal: AppDimensions.paddingMD,
  //                 vertical: AppDimensions.paddingSM,
  //               ),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     '${controller.totalCount.value} results found',
  //                     style: AppTextStyles.bodySmall.copyWith(
  //                       color: AppColors.textSecondary,
  //                     ),
  //                   ),
  //                   if (controller.searchQuery.value.isNotEmpty)
  //                     TextButton(
  //                       onPressed: controller.clearSearch,
  //                       child: const Text('Clear'),
  //                     ),
  //                 ],
  //               ),
  //             );
  //           }
  //           return const SizedBox();
  //         }),
  //
  //
  //         SizedBox(height: AppDimensions.paddingMD),
  //
  //         // Doctor list
  //         ListView.separated(
  //           shrinkWrap: true,
  //           physics: const NeverScrollableScrollPhysics(),
  //           itemCount: controller.doctors.length,
  //           separatorBuilder: (context, index) =>
  //               SizedBox(height: AppDimensions.paddingMD),
  //           itemBuilder: (context, index) {
  //             final doctor = controller.doctors[index];
  //             return DoctorCardWidget(
  //               doctor: doctor,
  //               onTap: () => controller.onDoctorTap(doctor),
  //               onFavorite: (){
  //
  //               },
  //               // onFavorite: () => controller.toggleFavorite(doctor),
  //             );
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
