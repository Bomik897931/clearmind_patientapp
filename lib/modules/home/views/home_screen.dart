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

/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/constant.dart';
import '../../../widgets/bottom_nav_bar.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/textWidget.dart';
import '../controller/home_controller.dart';
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
              // Icon(
              //   Icons.local_hospital,
              //   color: AppColors.white,
              //   size: AppDimensions.iconXL,
              // ),
              Image.asset('assets/images/applogo.png',width: AppDimensions.iconXL,height: AppDimensions.iconXL,),
              GestureDetector(
                onTap: (){
                  controller.onNotificationTap();
                },
                child: Icon(
                  Icons.notifications,
                  color: AppColors.white,
                  size: AppDimensions.iconLG,
                ),
              ),
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

          // Pagination controls
          if (controller.totalPages.value > 1) ...[
            SizedBox(height: AppDimensions.paddingLG),
            // _buildPaginationControls(),
          ],
        ],
      );
    });
  }

}*/




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../data/models/category_model.dart';
import '../../../widgets/bottom_nav_bar.dart';
import '../../../widgets/loading_widget.dart';
import '../controller/home_controller.dart';
import '../widgets/search_bar_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingWidget();
        }

        return SafeArea(
          child: Column(
            children: [
              _HeaderSection(controller: controller),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),

                      /// TRACK ORDER
                      _TrackOrderCard(),

                      SizedBox(height: 20.h),

                      /// QUICK ACTIONS
                      QuickActions(),

                      SizedBox(height: 20.h),

                      /// DOCTORS
                      _DoctorsSection(controller: controller),

                      // SizedBox(height: 90.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),

      bottomNavigationBar: Obx(
            () => BottomNavBar(
          currentIndex: controller.selectedBottomIndex.value,
        ),
      ),
    );
  }
}


class _HeaderSection extends StatelessWidget {
  final HomeController controller;
  const _HeaderSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: const BoxDecoration(
        color: Color(0xFFBF6D25),
        // borderRadius: BorderRadius.vertical(
        //   bottom: Radius.circular(24),
        // ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TOP ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // CircleAvatar(
              //   radius: 22,
              //   backgroundColor: Colors.white,
              //   child: const Icon(Icons.person, color: Color(0xFFBF6D25)),
              // ),
              _headerIcon(Icons.person),
              Row(
                children: [
                  _headerIcon(Icons.favorite_border),
                  SizedBox(width: 12),
                  GestureDetector(
                    onTap: controller.onNotificationTap, // ✅ SAME ACTION
                    child: _headerIcon(Icons.notifications_none),
                  ),
                ],
              )
            ],
          ),

          SizedBox(height: 16),

          /// GREETING
           Text(
            'Hi Aman',
            style: AppTextStyles.subHeading,
          ),
          const SizedBox(height: 4),
          Text(
            "Let's Find A Doctor",
            style: AppTextStyles.heading51,
          ),

          SizedBox(height: 16),

          /// SEARCH (same callback)
          SearchBarWidget(
            onChanged: controller.onSearchChanged, // ✅ SAME ACTION
          ),

          SizedBox(height: 18),

          /// CATEGORIES
          Obx(() {
            final apiList = controller.specializations;

            if (apiList.isEmpty) {
              return const SizedBox();
            }

            // 1️⃣ Static "All Doctors"
            final uiList = <_UiSpecialization>[
              _UiSpecialization(
                icon: Icons.grid_view_rounded,
                name: 'All Doctors',
                raw: null,
              ),
            ];

            // 2️⃣ Convert API → UI-safe objects
            for (final item in apiList.take(3)) {
              uiList.add(
                _UiSpecialization(
                  icon: item.icon ?? Icons.medical_services, // ✅ null-safe
                  name: item.specializationName ?? '',
                  raw: item,
                ),
              );
            }

            return Row(
              children: uiList.map((uiItem) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.onSpecializationTap(uiItem.raw as Specialization);
                    },

                    child: _CategoryIcon(
                      icon: uiItem.icon,
                      label: uiItem.name,
                    ),
                  ),
                );
              }).toList(),
            );
          }),


        ],
      ),
    );
  }

  Widget _headerIcon(IconData icon) {
    return Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: AppColors.primary),
    );
  }
}

class _UiSpecialization {
  final IconData icon;
  final String name;
  final Object? raw; // original API object

  _UiSpecialization({
    required this.icon,
    required this.name,
    this.raw,
  });
}



class _CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _CategoryIcon({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            color: const Color(0xFFBF6D25),
            size: 24,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}






class _TrackOrderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            // width: 20,
            // height: 20,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFBF6D25).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.medication, color: Color(0xFFBF6D25),size: 12,),
          ),
          SizedBox(width: 12),
           Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: AppDimensions.paddingXS),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Track Your Order',
                      style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: AppColors.textPrimary)),
                  Text(
                    'Check Prescription Or Medicine Delivery Status',
                    style: TextStyle(fontSize: 10, color: AppColors.primary),
                  ),
                ],
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}


class QuickActions extends StatelessWidget {
  const QuickActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: (){
            Get.toNamed('/review-confirm'/*, arguments: {
              'doctor': doctor.value,
              'selectedDate': selectedDate.value,
              'selectedTime': selectedDate.value,
              'consultationDuration': selectedDuration.value,
              'selectedIdProof': selectedIdProof.value,
              'age': ageController.text,
              'gender': selectedGender.value,
            }*/);
          },
          child: const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),

        /// ✅ Horizontal scroll like Figma
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _quickActionChip(
                icon: Icons.article_outlined,
                label: 'View Content',
                onTap: () {},
              ),
              const SizedBox(width: 8),
              _quickActionChip(
                icon: Icons.calendar_today,
                label: 'Upcoming Appointment',
                onTap: () => Get.toNamed('/my-appointments'),
              ),
              const SizedBox(width: 8),
              _quickActionChip(
                icon: Icons.schedule,
                label: 'Book Slot',
                onTap: () => Get.toNamed('/slots'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// ==============================
  /// FIGMA QUICK ACTION CHIP
  /// ==============================
  Widget _quickActionChip({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8), // ✅ Padding 8px
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3E9), // ✅ primary color/09 (#FFF3E9)
          borderRadius: BorderRadius.circular(12), // ✅ Radius 12px
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // ✅ Hug width
          children: [
            Icon(
              icon,
              size: 16,
              color: const Color(0xFFBF6D25),
            ),
            const SizedBox(width: 8), // ✅ Gap 8px
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}





class _DoctorsSection extends StatelessWidget {
  final HomeController controller;
  const _DoctorsSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.doctors.isEmpty &&
          !controller.isSearching.value) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: const Text('No doctors available'),
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Doctors',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          ...controller.doctors.map((doctor) {
            return GestureDetector(
              onTap: () =>
                  controller.onDoctorTap(doctor), // ✅ SAME
              child: _DoctorTile(doctor: doctor),
            );
          }).toList(),
        ],
      );
    });
  }
}

class _DoctorTile extends StatelessWidget {
  final dynamic doctor;
  const _DoctorTile({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(14),
      // ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.grey.shade200,
            child: Text(doctor.firstName[0]),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dr. ${doctor.firstName} ${doctor.lastName}',
                    style:
                    AppTextStyles.heading5),
                Text(doctor.specialty,
                    style: AppTextStyles.heading5_1),
                Text('₹ ${doctor.fees}',
                    style:
                    AppTextStyles.heading5_2),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}

