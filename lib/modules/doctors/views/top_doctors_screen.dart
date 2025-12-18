import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/loading_widget.dart';
import '../controllers/top_doctors_controller.dart';
import '../widgets/doctor_list_item.dart';

class TopDoctorsScreen extends GetView<TopDoctorsController> {
  const TopDoctorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: CustomAppBar(
        title: controller.selectedCategory.value.isEmpty
            ? AppStrings.topDoctors
            : controller.selectedCategory.value,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingWidget();
        }

        return ListView.separated(
          padding: EdgeInsets.all(AppDimensions.paddingMD),
          itemCount: controller.doctors.length,
          separatorBuilder: (context, index) =>
              SizedBox(height: AppDimensions.paddingMD),
          itemBuilder: (context, index) {
            final doctor = controller.doctors[index];
            return DoctorListItem(
              doctor: doctor,
              onTap: () => controller.onDoctorTap(doctor),
              onFavorite: () => controller.toggleFavorite(doctor),
            );
          },
        );
      }),
    );
  }
}
