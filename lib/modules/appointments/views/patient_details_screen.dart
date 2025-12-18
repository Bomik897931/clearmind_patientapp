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
import '../controllers/patient_details_controller.dart';

class PatientDetailsScreen extends GetView<PatientDetailsController> {
  const PatientDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: CustomAppBar(title: AppStrings.patientDetails),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppDimensions.paddingMD),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    labelText: AppStrings.fullName,
                    controller: controller.fullNameController,
                  ),
                  SizedBox(height: AppDimensions.paddingMD),
                  _buildGenderDropdown(),
                  SizedBox(height: AppDimensions.paddingMD),
                  CustomTextField(
                    labelText: AppStrings.dateOfBirth,
                    hintText: '29th January 1990',
                    readOnly: true,
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  SizedBox(height: AppDimensions.paddingMD),
                  CustomTextField(
                    labelText: AppStrings.weight,
                    controller: controller.weightController,
                  ),
                  SizedBox(height: AppDimensions.paddingMD),
                  _buildBloodDropdown(),
                  SizedBox(height: AppDimensions.paddingMD),
                  Text(
                    AppStrings.writeYourSymptoms,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingSM),
                  CustomTextField(
                    controller: controller.symptomsController,
                    maxLines: 6,
                    hintText: 'Write your symptoms here...',
                  ),
                  SizedBox(height: AppDimensions.paddingXL),
                ],
              ),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            borderSide: const BorderSide(color: AppColors.border),
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

  Widget _buildBloodDropdown() {
    return Obx(
      () => DropdownButtonFormField<String>(
        value: controller.selectedBlood.value,
        decoration: InputDecoration(
          labelText: AppStrings.blood,
          filled: true,
          fillColor: AppColors.grey50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            borderSide: const BorderSide(color: AppColors.border),
          ),
        ),
        items:
            [
              'O Positive',
              'O Negative',
              'A Positive',
              'A Negative',
              'B Positive',
              'B Negative',
              'AB Positive',
              'AB Negative',
            ].map((blood) {
              return DropdownMenuItem(value: blood, child: Text(blood));
            }).toList(),
        onChanged: (value) {
          if (value != null) {
            controller.selectedBlood.value = value;
          }
        },
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: CustomButton(text: AppStrings.next, onPressed: controller.onNext),
    );
  }
}
