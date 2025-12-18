// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:patient_app/core/constants/app_text_style.dart';
// import '../../../core/constants/app_colors.dart';
// import '../../../core/constants/app_dimensions.dart';
// import '../../../core/constants/app_strings.dart';
// import '../../../widgets/custom_app_bar.dart';
// import '../../../widgets/custom_button.dart';
// import '../../../widgets/loading_widget.dart';
// import '../controllers/doctor_detail_controller.dart';
//
// class DoctorDetailScreen extends GetView<DoctorDetailController> {
//   const DoctorDetailScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.scaffoldBackground,
//       appBar: CustomAppBar(
//         title: controller.doctor.value?.firstName ?? '',
//         actions: [
//           // Obx(
//           //   () => IconButton(
//           //     icon: Icon(
//           //       controller.doctor.value?.isFavorite ?? false
//           //           ? Icons.favorite
//           //           : Icons.favorite_border,
//           //       color: controller.doctor.value?.isFavorite ?? false
//           //           ? AppColors.error
//           //           : AppColors.textPrimary,
//           //     ),
//           //     onPressed: controller.toggleFavorite,
//           //   ),
//           // ),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.doctor.value == null) {
//           return const LoadingWidget();
//         }
//
//         final doctor = controller.doctor.value!;
//
//         return Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.all(AppDimensions.paddingMD),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildDoctorHeader(doctor),
//                     SizedBox(height: AppDimensions.paddingLG),
//                     _buildAboutSection(doctor),
//                     SizedBox(height: AppDimensions.paddingLG),
//                     _buildWorkingTimeSection(doctor),
//                     SizedBox(height: AppDimensions.paddingLG),
//                     _buildReviewsSection(),
//                     SizedBox(height: AppDimensions.paddingXL),
//                   ],
//                 ),
//               ),
//             ),
//             _buildBottomBar(),
//           ],
//         );
//       }),
//     );
//   }
//
//   Widget _buildDoctorHeader(doctor) {
//     return Container(
//       padding: EdgeInsets.all(AppDimensions.paddingMD),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 100.w,
//             height: 100.w,
//             decoration: BoxDecoration(
//               color: AppColors.grey100,
//               borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//             ),
//             child: Icon(
//               Icons.person,
//               size: 50.w,
//               color: AppColors.textTertiary,
//             ),
//           ),
//           SizedBox(width: AppDimensions.paddingMD),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(doctor.name, style: AppTextStyles.h5),
//                 SizedBox(height: AppDimensions.paddingXS),
//                 Container(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: AppDimensions.paddingSM,
//                     vertical: 4.h,
//                   ),
//                   decoration: BoxDecoration(
//                     color: AppColors.primary.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
//                   ),
//                   child: Text(
//                     doctor.specialty,
//                     style: AppTextStyles.caption.copyWith(
//                       color: AppColors.primary,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: AppDimensions.paddingSM),
//                 Text(doctor.hospital, style: AppTextStyles.bodySmall),
//                 SizedBox(height: AppDimensions.paddingSM),
//                 Row(
//                   children: [
//                     Icon(Icons.star, color: AppColors.rating, size: 16.w),
//                     SizedBox(width: 4.w),
//                     Text(
//                       '${doctor.rating}',
//                       style: AppTextStyles.bodyMedium.copyWith(
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(width: 4.w),
//                     Text(
//                       '(${doctor.reviewCount} reviews)',
//                       style: AppTextStyles.caption,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: AppDimensions.paddingXS),
//                 Text(
//                   'Experience: ${doctor.experience}+ Years',
//                   style: AppTextStyles.caption,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAboutSection(doctor) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(AppStrings.aboutMe, style: AppTextStyles.h6),
//         SizedBox(height: AppDimensions.paddingSM),
//         Text(
//           doctor.about.isEmpty
//               ? 'Dr. ${doctor.name} is the top most immunologists specialist in ${doctor.hospital}. She achieved several awards for her wonderful contribution in medical field.'
//               : doctor.about,
//           style: AppTextStyles.bodyMedium.copyWith(
//             color: AppColors.textSecondary,
//             height: 1.6,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildWorkingTimeSection(doctor) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(AppStrings.workingTime, style: AppTextStyles.h6),
//         SizedBox(height: AppDimensions.paddingSM),
//         Text(
//           doctor.workingTime,
//           style: AppTextStyles.bodyMedium.copyWith(
//             color: AppColors.textSecondary,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildReviewsSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(AppStrings.reviews, style: AppTextStyles.h6),
//             TextButton(
//               onPressed: controller.onWriteReview,
//               child: Text(
//                 AppStrings.seeAll,
//                 style: AppTextStyles.bodyMedium.copyWith(
//                   color: AppColors.primary,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: AppDimensions.paddingMD),
//         Obx(() {
//           if (controller.isLoading.value) {
//             return const LoadingWidget();
//           }
//
//           return ListView.separated(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: controller.reviews.take(3).length,
//             separatorBuilder: (context, index) =>
//                 SizedBox(height: AppDimensions.paddingMD),
//             itemBuilder: (context, index) {
//               final review = controller.reviews[index];
//               return Container(
//                 padding: EdgeInsets.all(AppDimensions.paddingMD),
//                 decoration: BoxDecoration(
//                   color: AppColors.white,
//                   borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           width: 40.w,
//                           height: 40.w,
//                           decoration: BoxDecoration(
//                             color: AppColors.grey100,
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             Icons.person,
//                             size: 20.w,
//                             color: AppColors.textTertiary,
//                           ),
//                         ),
//                         SizedBox(width: AppDimensions.paddingSM),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 review.userName,
//                                 style: AppTextStyles.bodyMedium.copyWith(
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               SizedBox(height: 4.h),
//                               RatingBar.builder(
//                                 initialRating: review.rating,
//                                 minRating: 1,
//                                 direction: Axis.horizontal,
//                                 allowHalfRating: true,
//                                 itemCount: 5,
//                                 itemSize: 16.w,
//                                 ignoreGestures: true,
//                                 itemBuilder: (context, _) => const Icon(
//                                   Icons.star,
//                                   color: AppColors.rating,
//                                 ),
//                                 onRatingUpdate: (rating) {},
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: AppDimensions.paddingSM),
//                     Text(
//                       review.comment,
//                       style: AppTextStyles.bodySmall.copyWith(
//                         color: AppColors.textSecondary,
//                         height: 1.5,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         }),
//       ],
//     );
//   }
//
//   Widget _buildBottomBar() {
//     return Container(
//       padding: EdgeInsets.all(AppDimensions.paddingMD),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.shadow,
//             blurRadius: 8,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: CustomButton(
//         text: AppStrings.bookAppointment,
//         onPressed: controller.onBookAppointment,
//       ),
//     );
//   }
// }


// lib/modules/doctors/screens/doctor_detail_screen.dart


//2nd
/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../widgets/loading_widget.dart';
import '../controllers/doctor_detail_controller.dart';

class DoctorDetailScreen extends GetView<DoctorDetailController> {
  const DoctorDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingWidget();
        }

        final doctor = controller.doctor.value;
        if (doctor == null) {
          return const Center(child: Text('Doctor not found'));
        }

        return CustomScrollView(
          slivers: [
            // App Bar with Image
            SliverAppBar(
              expandedHeight: 200.h,
              pinned: true,
              backgroundColor: AppColors.primary,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Get.back(),
              ),
              actions: [
                Obx(() => IconButton(
                  icon: Icon(
                    controller.isFavorite.value
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.white,
                  ),
                  onPressed: controller.toggleFavorite,
                )),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50.w,
                          backgroundColor: Colors.white,
                          child: Text(
                            doctor.firstName[0].toUpperCase(),
                            style: AppTextStyles.h1.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(AppDimensions.paddingMD),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Doctor Name & Basic Info
                    _buildBasicInfo(doctor),
                    SizedBox(height: AppDimensions.paddingLG),

                    // Stats Cards
                    _buildStatsRow(doctor),
                    SizedBox(height: AppDimensions.paddingLG),

                    // Specializations
                    _buildSpecializationsSection(doctor),
                    SizedBox(height: AppDimensions.paddingLG),

                    // About Section
                    _buildAboutSection(doctor),
                    SizedBox(height: AppDimensions.paddingLG),

                    // Contact Information
                    _buildContactSection(doctor),
                    SizedBox(height: AppDimensions.paddingLG),

                    // Location
                    _buildLocationSection(doctor),
                    SizedBox(height: 100.h), // Space for button
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        final doctor = controller.doctor.value;
        if (doctor == null) return const SizedBox();

        return Container(
          padding: EdgeInsets.all(AppDimensions.paddingMD),
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Consultation Fee',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.currency_rupee,
                          size: 18.w,
                          color: AppColors.primary,
                        ),
                        Text(
                          doctor.fees.toStringAsFixed(0),
                          style: AppTextStyles.h5.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: AppDimensions.paddingMD),
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.onBookAppointment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                      ),
                    ),
                    child: Text(
                      AppStrings.bookAppointment,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBasicInfo(dynamic doctor) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dr. ${doctor.fullName}',
              style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppDimensions.paddingXS),
            Text(
              doctor.education,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: AppDimensions.paddingXS),
            Row(
              children: [
                Icon(Icons.person, size: 16.w, color: AppColors.textTertiary),
                SizedBox(width: 4.w),
                Text(
                  '${doctor.gender} • ${doctor.age} years',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(dynamic doctor) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.work_outline,
            label: 'Experience',
            value: '${doctor.experienceYears} Years',
            color: AppColors.primary,
          ),
        ),
        SizedBox(width: AppDimensions.paddingSM),
        Expanded(
          child: _buildStatCard(
            icon: Icons.verified_outlined,
            label: 'Status',
            value: doctor.isActive ? 'Active' : 'Inactive',
            color: doctor.isActive ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32.w),
            SizedBox(height: AppDimensions.paddingXS),
            Text(
              value,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecializationsSection(dynamic doctor) {
    List<Map<String, dynamic>> specializations = [];

    if (doctor.isPsychiatrist) {
      specializations.add({
        'name': 'Psychiatrist',
        'icon': Icons.psychology,
      });
    }
    if (doctor.isPsychologist) {
      specializations.add({
        'name': 'Psychologist',
        'icon': Icons.person_outline,
      });
    }
    if (doctor.isTherapist) {
      specializations.add({
        'name': 'Therapist',
        'icon': Icons.medical_services_outlined,
      });
    }

    if (specializations.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Specializations',
          style: AppTextStyles.h6.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: AppDimensions.paddingSM),
        Wrap(
          spacing: AppDimensions.paddingSM,
          runSpacing: AppDimensions.paddingSM,
          children: specializations.map((spec) {
            return Chip(
              avatar: Icon(
                spec['icon'],
                size: 18.w,
                color: AppColors.primary,
              ),
              label: Text(spec['name']),
              backgroundColor: AppColors.primary.withOpacity(0.1),
              labelStyle: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAboutSection(dynamic doctor) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: AppTextStyles.h6.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppDimensions.paddingSM),
            Text(
              doctor.about,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection(dynamic doctor) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Information',
              style: AppTextStyles.h6.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppDimensions.paddingSM),
            _buildContactItem(
              icon: Icons.email_outlined,
              label: 'Email',
              value: doctor.email,
            ),
            SizedBox(height: AppDimensions.paddingSM),
            _buildContactItem(
              icon: Icons.phone_outlined,
              label: 'Phone',
              value: doctor.phoneNumber,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20.w),
        SizedBox(width: AppDimensions.paddingSM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
              Text(
                value,
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationSection(dynamic doctor) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: AppColors.primary, size: 20.w),
                SizedBox(width: AppDimensions.paddingSM),
                Text(
                  'Location',
                  style: AppTextStyles.h6.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.paddingSM),
            Text(
              doctor.address,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/core/constants/app_strings.dart';

import '../../../core/routes/app_routes.dart';
import '../controllers/doctor_detail_controller.dart';

class DoctorDetailScreen extends StatelessWidget {
  const DoctorDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DoctorDetailController>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Obx(() => Text(
          controller.doctor.value?.fullName ?? 'Doctor Details',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        )),
        actions: [
          Obx(() => IconButton(
            icon: Icon(
              controller.isFavorite.value ? Icons.favorite : Icons.favorite_border,
              color: controller.isFavorite.value ? Colors.red : Colors.grey[600],
            ),
            onPressed: controller.toggleFavorite,
          )),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF00BCD4),
            ),
          );
        }

        if (controller.doctor.value == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'Failed to load doctor details',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.refresh,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BCD4),
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final doctor = controller.doctor.value!;

        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Doctor Card
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Doctor Image
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: NetworkImage(doctor.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Doctor Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor.fullName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                doctor.specialty,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                doctor.wokingHospital,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Stats Row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        _buildStatCard(
                          icon: Icons.people,
                          value: '${doctor.patients}+',
                          label: 'Patients',
                          color: const Color(0xFFE0F7FA),
                        ),
                        const SizedBox(width: 12),
                        _buildStatCard(
                          icon: Icons.work,
                          value: '${doctor.experienceYears}+',
                          label: 'Years exper...',
                          color: const Color(0xFFE0F7FA),
                        ),
                        const SizedBox(width: 12),
                        _buildStatCard(
                          icon: Icons.star,
                          value: doctor.rating,
                          label: 'Rating',
                          color: const Color(0xFFE0F7FA),
                        ),
                        const SizedBox(width: 12),
                        _buildStatCard(
                          icon: Icons.chat,
                          value: '${doctor.reviews}',
                          label: AppStrings.aboutMe,
                          color: const Color(0xFFE0F7FA),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // About Me Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'About me',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          doctor.about,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Working Time Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Working Time',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          doctor.wokingTime,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Reviews Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Reviews',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(
                              AppRoutes.REVIEWS_LIST,
                              arguments: {
                                'doctor': doctor,
                                // 'doctorName': appointment.doctorName,
                                // 'appointmentId': appointment.appointmentId,
                              },
                            );
                            // Navigate to all reviews
                          },
                          child: const Text(
                            'See All',
                            style: TextStyle(
                              color: Color(0xFF00BCD4),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Sample Review Card
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.grey[300],
                              child: Icon(Icons.person, color: Colors.grey[600]),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Charolette Hanlin',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE0F7FA),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Color(0xFF00BCD4),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '5',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF00BCD4),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Dr. Jenny is very professional in her work and responsive I have consulted and my problem is solved. 😊🔥',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Book Appointment Button
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: controller.onBookAppointment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00BCD4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Book Appointment',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF00BCD4),
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}