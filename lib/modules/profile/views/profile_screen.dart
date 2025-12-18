import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/constants/app_text_style.dart';
import 'package:patient_app/modules/profile/controllers/edit_profile_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/bottom_nav_bar.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_menu_item.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: AppDimensions.paddingLG),
            _buildProfileHeader(),
            SizedBox(height: AppDimensions.paddingLG),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMD,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.aboutApp,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: AppDimensions.paddingMD),
                    ProfileMenuItem(
                      icon: Icons.notifications_outlined,
                      title: "Language",
                      iconColor: AppColors.warning,
                      trailing: Obx(
                        () => Switch(
                          value: controller.notificationEnabled.value,
                          onChanged: controller.toggleLanguage,
                          activeColor: AppColors.primary,
                        ),
                      ),
                    ),
                    // SizedBox(height: AppDimensions.paddingMD),
                    // ProfileMenuItem(
                    //   icon: Icons.language,
                    //   title: AppStrings.notification,
                    //   iconColor: AppColors.warning,
                    //   trailing: Obx(
                    //         () => Switch(
                    //       value: controller.languagebool.value,
                    //       onChanged: controller.toggleNotification,
                    //       activeColor: AppColors.primary,
                    //     ),
                    //   ),
                    // ),
                    // ProfileMenuItem(
                    //   icon: Icons.lock_outline,
                    //   title: AppStrings.changePassword,
                    //   iconColor: Colors.pink,
                    //   onTap: controller.onChangePassword,
                    // ),
                    ProfileMenuItem(
                      icon: Icons.help_outline,
                      title: AppStrings.faqs,
                      iconColor: AppColors.success,
                      onTap: controller.onFAQs,
                    ),
                    ProfileMenuItem(
                      icon: Icons.support_agent,
                      title: AppStrings.help,
                      iconColor: AppColors.info,
                      onTap: controller.onHelp,
                    ),
                    ProfileMenuItem(
                      icon: Icons.logout,
                      title: AppStrings.logout,
                      iconColor: AppColors.error,
                      onTap: controller.logout,
                      showArrow: false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavBar(currentIndex: controller.selectedBottomIndex.value),
      ),
    );
  }

  Widget _buildProfileHeader() {

    final editcontroller = Get.put(EditProfileController());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingMD),
      child: Row(
        children: [
          Container(
            width: 70.w,
            height: 70.w,
            decoration: BoxDecoration(
              color: AppColors.grey100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              size: 35.w,
              color: AppColors.textTertiary,
            ),
          ),
          SizedBox(width: AppDimensions.paddingMD),

          Expanded(
            child:
            Obx(() {
              final user = editcontroller.currentUser.value;

              if (user == null) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.firstName, style: AppTextStyles.h5),
                  SizedBox(height: 4.h),
                  Text(user.email, style: AppTextStyles.bodySmall),
                ],
              );
            })
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(editcontroller.currentUser.value!.firstName, style: AppTextStyles.h5),
            //     SizedBox(height: 4.h),
            //     Text(editcontroller.currentUser.value!.email, style: AppTextStyles.bodySmall),
            //   ],
            // ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.primary),
            onPressed: controller.onEditProfile,
          ),
        ],
      ),
    );
  }
}
