import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../data/models/category_model.dart';
import '../../../widgets/bottom_nav_bar.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/textWidget.dart';
import '../../Cart/controller/MyPrescriptions_Controller.dart';
import '../../Cart/controller/cart_controller.dart';
import '../../Cart/views/cart.dart';
import '../../Cart/views/prescription_screen.dart';
import '../../appointments/controllers/my_appointments_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controller/home_controller.dart';
import '../widgets/search_bar_widget.dart';

// Import your other screens
import '../../appointments/views/my_appointments_screen.dart'; // ← Add this// ← Add this
import '../../profile/views/profile_screen.dart'; // ← Add this

const double referenceHeight = 800;

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    Get.lazyPut(() => MyAppointmentsController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => CartController(), fenix: true);

    return Scaffold(
      backgroundColor: AppColors.white,

      // ✅ MAIN CHANGE: Use IndexedStack instead of single body
      body: Obx(
        () => IndexedStack(
          index: controller.selectedBottomIndex.value,
          children: [
            _buildHomeTab(context, screenHeight), // Tab 0: Home

            MyAppointmentsScreen(), // Tab 1: Appointments
            // MyPrescriptionsScreen(), // Tab 2: Cart
            CartScreen(),
            ProfileScreen(), // Tab 3: Profile
          ],
        ),
      ),

      bottomNavigationBar: Obx(
        () => BottomNavBar(currentIndex: controller.selectedBottomIndex.value),
      ),
    );
  }

  // ✅ Extract home content into separate method
  Widget _buildHomeTab(BuildContext context, double screenHeight) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const LoadingWidget();
      }

      return SafeArea(
        child: Column(
          children: [
            _HeaderSection(controller: controller),

            Expanded(
              child: SingleChildScrollView(
                controller: controller.scrollController,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 16 / referenceHeight),

                    /// TRACK ORDER
                    _TrackOrderCard(),

                    SizedBox(height: screenHeight * 24 / referenceHeight),

                    /// QUICK ACTIONS
                    QuickActions(),

                    SizedBox(height: screenHeight * 16 / referenceHeight),

                    /// DOCTORS
                    _DoctorsSection(controller: controller),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _HeaderSection extends StatelessWidget {
  final HomeController controller;
  const _HeaderSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: const BoxDecoration(color: AppColors.primary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TOP ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(Assets.userImagePng),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.onFavoriteTap();
                    },
                    child: _headerIcon(Assets.likeIcon),
                  ),
                  SizedBox(width: screenHeight * 16 / referenceHeight),
                  GestureDetector(
                    onTap: controller.onNotificationTap,
                    child: _headerIcon(Assets.notificationIcon),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: screenHeight * 16 / referenceHeight),

          /// GREETING
          Text('Hi Aman', style: AppTextStyles.subHeading),
          SizedBox(height: screenHeight * 4 / referenceHeight),
          SizedBox(
            width: 122,
            height: 21,
            child: Text(
              "Let’s Find a doctor",
              style: TextStyle(
                fontFamily: 'EBGaramond',
                fontSize: 14,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                height: 21 / 14, // lineHeight / fontSize
                letterSpacing: -0.011 * 14, // -1.1%
              ),
            ),
          ),

          SizedBox(height: screenHeight * 24 / referenceHeight),

          /// SEARCH
          SearchBarWidget(onChanged: controller.onSearchChanged),

          SizedBox(height: screenHeight * 24 / referenceHeight),

          /// CATEGORIES
          Obx(() {
            final apiList = controller.specializations;

            if (apiList.isEmpty) {
              return const SizedBox();
            }

            final uiList = <_UiSpecialization>[
              _UiSpecialization(
                icon: Assets.all,
                name: 'All Doctors',
                raw: Specialization(
                  specializationId: 0,
                  specializationName: 'All',
                ),
              ),
            ];

            for (final item in apiList.take(3)) {
              uiList.add(
                _UiSpecialization(
                  icon: item.icon,
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
                      controller.onSpecializationTap(
                        uiItem.raw as Specialization,
                      );
                    },
                    child: _CategoryIcon(icon: uiItem.icon, label: uiItem.name),
                  ),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  Widget _headerIcon(String icon) {
    return Container(
      width: 40,
      height: 40,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        shape: BoxShape.circle,
      ),
      child: SizedBox(child: SvgPicture.asset(icon, height: 24, width: 24)),
    );
  }
}

class _UiSpecialization {
  final String icon;
  final String name;
  final Object? raw;

  _UiSpecialization({required this.icon, required this.name, this.raw});
}

class _CategoryIcon extends StatelessWidget {
  final String icon;
  final String label;

  const _CategoryIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    const double referenceHeight = 800;

    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            icon,
            fit: BoxFit.contain,
            color: const Color(0xFFBF6D25),
          ),
        ),
        SizedBox(height: screenHeight * 8 / referenceHeight),
        mediumtext(text: label, fontsize: 12, color: AppColors.white),
      ],
    );
  }
}

class _TrackOrderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 40 / referenceHeight,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.extraPrimaryLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.locationIcon, height: 20, width: 20),
          SizedBox(width: screenHeight * 8 / referenceHeight),
          Expanded(child: mediumtext(text: "Track Your Order", fontsize: 12)),
          const Icon(Icons.arrow_forward_ios, size: 14),
        ],
      ),
    );
  }
}

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed('/review-confirm');
          },
          child: mediumtext(text: "Quick Actions", fontsize: 16),
        ),
        const SizedBox(height: 12),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _quickActionChip(
                icon: Assets.documentIcon,
                label: 'Upcoming Appointment',
                onTap: () => Get.toNamed('/my-appointments'),
              ),
              const SizedBox(width: 8),
              _quickActionChip(
                icon: Assets.openBookIcon,
                label: 'View Content',
                onTap: () {},
              ),
              const SizedBox(width: 8),
              _quickActionChip(
                icon: Assets.paperWriteIcon,
                label: 'MH Test',
                onTap: () => Get.toNamed('/slots'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _quickActionChip({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.extraPrimaryLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(icon),
            SizedBox(width: 8),
            mediumtext(text: label, fontsize: 12),
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
      if (controller.doctors.isEmpty && !controller.isLoading.value) {
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
          mediumtext(text: 'Doctors', fontsize: 16),
          const SizedBox(height: 16),

          ...controller.doctors.map((doctor) {
            return GestureDetector(
              onTap: () => controller.onDoctorTap(doctor),
              child: _DoctorTile(doctor: doctor),
            );
          }),

          if (controller.hasNext.value && controller.isLoading.value)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            ),
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
    const double referenceHeight = 800;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 72 / referenceHeight,
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(Assets.userImagePng),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: screenHeight * 16 / referenceHeight),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dr. ${doctor.firstName} ${doctor.lastName}',
                      style: AppTextStyles.heading5,
                    ),
                    Icon(Icons.arrow_forward_ios, size: 12),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  doctor.specialty,
                  softWrap: true,
                  style: AppTextStyles.bodySmallGrey,
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    SvgPicture.asset(Assets.rupeesIcon),
                    SizedBox(width: 2),
                    Text('${doctor.fees}', style: AppTextStyles.bodySmall),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
