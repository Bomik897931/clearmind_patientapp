import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 20.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name Field
            _buildTextField(
              label: "Name",
              controller: controller.fullNameController,
              hintText: "Enter your name",
            ),
            SizedBox(height: 16.h),

            // Age Dropdown
            Obx(() => _buildDropdownField<int>(
              label: "Age",
              value: controller.selectedAge.value,
              items: List.generate(100, (index) => index + 1)
                  .map((age) => DropdownMenuItem(
                value: age,
                child: Text('$age Years'),
              ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.selectedAge.value = value;
                }
              },
            )),
            SizedBox(height: 16.h),

            // Gender Dropdown
            Obx(() => _buildDropdownField<String>(
              label: "Gender",
              value: controller.selectedGender.value,
              items: ['Male', 'Female', 'Other']
                  .map((gender) => DropdownMenuItem(
                value: gender,
                child: Text(gender),
              ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.selectedGender.value = value;
                }
              },
            )),
            SizedBox(height: 16.h),

            // Email Field
            _buildTextField(
              label: "Email",
              controller: controller.emailController,
              hintText: "Enter your email",
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 32.h),

            // Update Button
            _buildUpdateButton(),
          ],
        ),
      ),
    );
  }

  // AppBar with Figma specs
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.w),
        onPressed: () => Get.back(),
      ),
      title: Text(
        "Edit Profile",
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
          height: 27 / 18, // Line height 27px / font size 18px
          letterSpacing: -0.11 * 18 / 100, // -1.1% letter spacing
        ),
      ),
      centerTitle: false,
    );
  }

  // Text Field Widget with Figma specs
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hintText,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label - Figma specs: heading 4 - Quicksand, 16px, Medium (500)
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
              height: 24 / 16, // Line height 24px / font size 16px
              letterSpacing: -0.11 * 16 / 100, // -1.1% letter spacing
            ),
          ),
        ),

        // Text Field Container - Full width, responsive height
        SizedBox(
          width: double.infinity,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              height: 1.5,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF9E9E9E),
                height: 1.5,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: Color(0xFFE0E0E0),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: Color(0xFFE0E0E0),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Dropdown Field Widget with Figma specs
  Widget _buildDropdownField<T>({
    required String label,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label - Figma specs: heading 4 - Quicksand, 16px, Medium (500)
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              height: 24 / 16, // Line height 24px / font size 16px
              letterSpacing: -0.11 * 16 / 100, // -1.1% letter spacing
            ),
          ),
        ),

        // Dropdown Field Container - Full width, responsive height
        SizedBox(
          width: double.infinity,
          child: DropdownButtonFormField<T>(
            value: value,
            items: items,
            onChanged: onChanged,
            isExpanded: true,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
              size: 24.w,
            ),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              height: 1.5,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: Color(0xFFE0E0E0),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: Color(0xFFE0E0E0),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Update Button with exact Figma specs
  // Button specs: Width Fill (328px), Height 40px, Radius 24px, Padding 11px 112px
  Widget _buildUpdateButton() {
    return SizedBox(
      width: double.infinity, // Fill width - adapts to screen size
      height: 40.h, // Fixed height 40px
      child: ElevatedButton(
        onPressed: controller.onUpdate,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFBC6C25), // Primary color #BC6C25
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r), // Radius 24px
          ),
          padding: EdgeInsets.symmetric(
            vertical: 11.h, // Top & Bottom padding 11px
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          "Update",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            height: 1.2,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}