import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/constants/app_text_style.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: CustomAppBar(title: AppStrings.editProfile),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          children: [
            _buildProfileImage(),
            SizedBox(height: AppDimensions.paddingLG),
            CustomTextField(
              labelText: AppStrings.fullName,
              controller: controller.fullNameController,
              suffixIcon: IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: () => controller.fullNameController.clear(),
              ),
            ),
            SizedBox(height: AppDimensions.paddingMD),
            _buildGenderDropdown(),
            SizedBox(height: AppDimensions.paddingMD),
            _buildAgeDropdown(),
            SizedBox(height: AppDimensions.paddingMD),
            CustomTextField(
              labelText: AppStrings.emailID,
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              suffixIcon: const Icon(Icons.email_outlined, size: 20),
            ),
            SizedBox(height: AppDimensions.paddingMD),
            _buildPhoneField(),
            SizedBox(height: AppDimensions.paddingXL),
            CustomButton(
              text: AppStrings.update,
              onPressed: controller.onUpdate,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      children: [
        Container(
          width: 100.w,
          height: 100.w,
          decoration: BoxDecoration(
            color: AppColors.grey100,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.person, size: 50.w, color: AppColors.textTertiary),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white, width: 2),
            ),
            child: Icon(Icons.edit, size: 16.w, color: AppColors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return Obx(
      () => DropdownButtonFormField<String>(
        value: controller.selectedGender.value,
        decoration: InputDecoration(
          labelText: AppStrings.gender,
          filled: true,
          fillColor: AppColors.grey50,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMD,
            vertical: AppDimensions.paddingMD,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
        items: ['Male', 'Female', 'Other'].map((gender) {
          return DropdownMenuItem(value: gender, child: Text(gender));
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            controller.selectedGender.value = value;
          }
        },
      ),
    );
  }

  Widget _buildAgeDropdown() {
    return Obx(
      () => DropdownButtonFormField<int>(
        value: controller.selectedAge.value,
        decoration: InputDecoration(
          labelText: AppStrings.yourAge,
          filled: true,
          fillColor: AppColors.grey50,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMD,
            vertical: AppDimensions.paddingMD,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
        items: List.generate(100, (index) => index + 1).map((age) {
          return DropdownMenuItem(value: age, child: Text('$age years'));
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            controller.selectedAge.value = value;
          }
        },
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMD,
              vertical: AppDimensions.paddingMD,
            ),
            child: Row(
              children: [
                Container(
                  width: 28.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Image.asset(
                    'assets/images/india_flag.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.orange,
                        child: const Center(
                          child: Text('🇮🇳', style: TextStyle(fontSize: 14)),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 8.w),
                const Icon(Icons.arrow_drop_down, size: 20),
              ],
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller.phoneController,
              keyboardType: TextInputType.phone,
              style: AppTextStyles.bodyMedium,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Phone Number',
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textTertiary,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMD,
                  vertical: AppDimensions.paddingMD,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
