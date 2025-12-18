// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:patient_app/core/constants/app_text_style.dart';
// import 'package:patient_app/modules/appointments/widgets.dart/appointment_card.dart';
// import '../../../core/constants/app_colors.dart';
// import '../../../core/constants/app_dimensions.dart';
// import '../../../core/constants/app_strings.dart';
// import '../../../widgets/bottom_nav_bar.dart';
// import '../../../widgets/loading_widget.dart';
// import '../controllers/my_appointments_controller.dart';
//
// class MyAppointmentsScreen extends GetView<MyAppointmentsController> {
//   const MyAppointmentsScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.scaffoldBackground,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(AppStrings.myAppointment, style: AppTextStyles.h5),
//         bottom: TabBar(
//           controller: controller.tabController,
//           labelColor: AppColors.primary,
//           unselectedLabelColor: AppColors.textSecondary,
//           indicatorColor: AppColors.primary,
//           labelStyle: AppTextStyles.bodyMedium.copyWith(
//             fontWeight: FontWeight.w600,
//           ),
//           tabs:  [
//             Tab(text: AppStrings.upcoming),
//             Tab(text: AppStrings.completed),
//           ],
//         ),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const LoadingWidget();
//         }
//
//         return TabBarView(
//           controller: controller.tabController,
//           children: [
//             _buildAppointmentsList(controller.upcomingAppointments, true),
//             _buildAppointmentsList(controller.completedAppointments, false),
//           ],
//         );
//       }),
//       bottomNavigationBar: Obx(
//         () => BottomNavBar(currentIndex: controller.selectedBottomIndex.value),
//       ),
//     );
//   }
//
//   Widget _buildAppointmentsList(List appointments, bool isUpcoming) {
//     if (appointments.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.calendar_today_outlined,
//               size: 64.w,
//               color: AppColors.textTertiary,
//             ),
//             SizedBox(height: AppDimensions.paddingMD),
//             Text(
//               'No appointments found',
//               style: AppTextStyles.bodyMedium.copyWith(
//                 color: AppColors.textSecondary,
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//
//     return ListView.separated(
//       padding: EdgeInsets.all(AppDimensions.paddingMD),
//       itemCount: appointments.length,
//       separatorBuilder: (context, index) =>
//           SizedBox(height: AppDimensions.paddingMD),
//       itemBuilder: (context, index) {
//         final appointment = appointments[index];
//         return AppointmentCard(
//           appointment: appointment,
//           isUpcoming: isUpcoming,
//           onTap: () => controller.onAppointmentTap(appointment),
//           onReschedule: () => controller.onReschedule(appointment),
//         );
//       },
//     );
//   }
//
//
//
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../widgets/bottom_nav_bar.dart';
import '../../../widgets/loading_widget.dart';
import '../controllers/my_appointments_controller.dart';
import '../widgets.dart/appointment_card.dart';



class MyAppointmentsScreen extends GetView<MyAppointmentsController> {
  const MyAppointmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(AppStrings.myAppointment, style: AppTextStyles.h5),
        bottom: TabBar(
          controller: controller.tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          labelStyle: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingWidget();
        }

        return TabBarView(
          controller: controller.tabController,
          children: [
            _buildAppointmentsList(controller.upcomingAppointments, 'upcoming'),
            _buildAppointmentsList(controller.completedAppointments, 'completed'),
            _buildAppointmentsList(controller.cancelledAppointments, 'cancelled'),
          ],
        );
      }),
      bottomNavigationBar: Obx(
            () => BottomNavBar(currentIndex: controller.selectedBottomIndex.value),
      ),
    );
  }

  Widget _buildAppointmentsList(List appointments, String type) {
    if (appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 64.w,
              color: AppColors.textTertiary,
            ),
            SizedBox(height: AppDimensions.paddingMD),
            Text(
              'No appointments found',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.all(AppDimensions.paddingMD),
      itemCount: appointments.length,
      separatorBuilder: (context, index) =>
          SizedBox(height: AppDimensions.paddingMD),
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return AppointmentCard(
          appointment: appointment,
          type: type,
          onTap: () => controller.onAppointmentTap(appointment),
          onReschedule: () => controller.onReschedule(appointment),
          onCancel: () => controller.onCancelAppointment(appointment),
          onLeaveReview: () => controller.onLeaveReview(appointment),
          onBookAgain: () => controller.onBookAgain(appointment),
          onCall: () => controller.onCall(appointment),
        );
      },
    );
  }
}

