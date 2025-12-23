// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../core/constants/app_colors.dart';
// import '../../../core/constants/app_dimensions.dart';
// import '../../../core/constants/app_strings.dart';
// import '../../../widgets/custom_app_bar.dart';
// import '../../../widgets/loading_widget.dart';
// import '../controllers/categories_controller.dart';
// import '../widgets/category_grid_item.dart';
//
// class CategoriesScreen extends GetView<CategoriesController> {
//   const CategoriesScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.scaffoldBackground,
//       appBar:  CustomAppBar(title: AppStrings.categories),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const LoadingWidget();
//         }
//
//         return Padding(
//           padding: EdgeInsets.all(AppDimensions.paddingMD),
//           child: GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: AppDimensions.paddingMD,
//               mainAxisSpacing: AppDimensions.paddingMD,
//               childAspectRatio: 0.85,
//             ),
//             itemCount: controller.categories.length,
//             itemBuilder: (context, index) {
//               final category = controller.categories[index];
//               return CategoryGridItem(
//                 category: category,
//                 onTap: () => controller.onCategoryTap(category),
//               );
//             },
//           ),
//         );
//       }),
//     );
//   }
// }

// lib/modules/doctors/screens/doctors_by_specialization_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../data/models/doctor_model.dart';
import '../../../widgets/loading_widget.dart';
import '../../doctors/widgets/doctor_list_item.dart';
import '../controllers/categories_controller.dart';

class DoctorsBySpecializationScreen extends GetView<DoctorsBySpecializationController> {
  const DoctorsBySpecializationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Get.back(),
        ),
        title: Obx(() => Text(
          controller.specialization.value?.specializationName ?? 'Doctors',
          style: const TextStyle(
            color: AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        )),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.search, color: AppColors.black),
        //     onPressed: () {
        //       // Implement search functionality
        //     },
        //   ),
        // ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.circularprogressindicator,
            ),
          );
        }

        if (controller.doctors.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.medical_services_outlined,
                  size: 64,
                  color: AppColors.grey400,
                ),
                const SizedBox(height: 16),
                Text(
                  'No doctors found',
                  style: TextStyle(
                    color: AppColors.grey600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refresh,
          color:  AppColors.circularprogressindicator,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.doctors.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final doctor = controller.doctors[index];
              return _buildDoctorCard(doctor);
            },
          ),
        );
      }),
    );
  }

  Widget _buildDoctorCard(DoctorModel doctor) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => controller.onDoctorTap(doctor),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Doctor Image
                // Container(
                //   width: 100,
                //   height: 120,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(12),
                //     image: DecorationImage(
                //       image: NetworkImage(doctor.imageUrl),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                const SizedBox(width: 16),
                // Doctor Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        doctor.fullName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${doctor.specialty} | ${doctor.wokingHospital}',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.grey600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            size: 18,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              '${doctor.rating} (${_formatReviews(doctor.reviews)} reviews)',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grey700,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Favorite Button
                Obx(() => IconButton(
                  onPressed: () => controller.toggleFavorite(doctor),
                  icon: Icon(
                    doctor.isFavorite.value ? Icons.favorite : Icons.favorite_border,
                    color: doctor.isFavorite.value ? AppColors.primary : AppColors.circularprogressindicator,
                    size: 28,
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatReviews(int reviews) {
    if (reviews >= 1000) {
      return '${(reviews / 1000).toStringAsFixed(1)}k';
    }
    return reviews.toString();
  }
}