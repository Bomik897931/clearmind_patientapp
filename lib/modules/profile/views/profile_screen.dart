import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/routes/app_routes.dart';
// ❌ REMOVE THIS IMPORT
// import '../../../widgets/bottom_nav_bar.dart';
import '../controllers/edit_profile_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.extraPrimaryLight,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Profile Header Section
            Container(
              color: AppColors.extraPrimaryLight,
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingMD,
                vertical: 16.h,
              ),
              child: _buildProfileHeader(),
            ),

            // Menu Section
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMD,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Menu Label
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Text(
                        "Menu",
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),

                    // Menu Items
                    _buildMenuItem(
                      icon: Icons.location_on_outlined,
                      title: "Save Address",
                      onTap: (){
                        print("sfzdxfcgvhbjkml,");
                        Get.toNamed(AppRoutes.SaveAddress);
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.payment_outlined,
                      title: "Payment History",
                      onTap: (){
                        Get.toNamed(AppRoutes.Prescription);
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.language_outlined,
                      title: "Language",
                      onTap: (){},
                    ),
                    _buildMenuItem(
                      icon: Icons.help_outline,
                      title: "FAQs",
                      onTap: controller.onFAQs,
                    ),
                    _buildMenuItem(
                      icon: Icons.support_agent_outlined,
                      title: "Help",
                      onTap: controller.onHelp,
                    ),
                    _buildMenuItem(
                      icon: Icons.logout_outlined,
                      title: "Logout",
                      onTap: controller.logout,
                      showArrow: false,
                      iconColor: AppColors.error,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // ❌ REMOVED bottomNavigationBar
    );
  }

  Widget _buildProfileHeader() {
    final editcontroller = Get.put(EditProfileController());
    return Column(
      children: [
        // Profile Info Row
        Row(
          children: [
            // Profile Image
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  Assets.userImagePng,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // User Name
            Expanded(
              child: Obx(() {
                final user = editcontroller.currentUser.value;

                if (user == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Text(
                  user.firstName,
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                );
              }),
            ),

            // Edit Button
            GestureDetector(
              onTap: controller.onEditProfile,
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.editIcon,
                    width: 20.w,
                    height: 20.h,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    "Edit",
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        // Action Buttons Row
        Row(
          children: [
            // My Orders Button
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Get.toNamed('/my-orders');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.myOrderIcon,
                        width: 20.w,
                        height: 20.h,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "My Orders",
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(width: 12.w),

            // Medical History Button
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoutes.MedicalReport);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.medicalHistoryIcon,
                        width: 20.w,
                        height: 20.h,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Medical History",
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool showArrow = true,
    Color? iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.grey100,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24.w,
              color: iconColor ?? AppColors.textSecondary,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  height: 21 / 14,
                  letterSpacing: -0.11 * 14 / 100,
                ),
              ),
            ),
            if (showArrow)
              Icon(
                Icons.chevron_right,
                size: 24.w,
                color: AppColors.textTertiary,
              ),
          ],
        ),
      ),
    );
  }
}