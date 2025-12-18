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
// import '../controllers/write_review_controller.dart';
//
// class WriteReviewScreen extends GetView<WriteReviewController> {
//   const WriteReviewScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.scaffoldBackground,
//       appBar: CustomAppBar(title: AppStrings.writeReview),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(AppDimensions.paddingMD),
//         child: Column(
//           children: [
//             _buildDoctorInfo(),
//             SizedBox(height: AppDimensions.paddingLG),
//             _buildReviewSection(),
//             SizedBox(height: AppDimensions.paddingXL),
//             _buildButtons(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDoctorInfo() {
//     return Obx(() {
//       final doctor = controller.doctor.value;
//       if (doctor == null) {
//         return Container(
//           padding: EdgeInsets.all(AppDimensions.paddingLG),
//           decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//           ),
//           child: Column(
//             children: [
//               Container(
//                 width: 100.w,
//                 height: 100.w,
//                 decoration: BoxDecoration(
//                   color: AppColors.grey100,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.person,
//                   size: 50.w,
//                   color: AppColors.textTertiary,
//                 ),
//               ),
//               SizedBox(height: AppDimensions.paddingMD),
//               Text('Dr. Marvin Boeson', style: AppTextStyles.h5),
//               SizedBox(height: 4.h),
//               Text(
//                 'Cardiologist',
//                 style: AppTextStyles.bodyMedium.copyWith(
//                   color: AppColors.textSecondary,
//                 ),
//               ),
//             ],
//           ),
//         );
//       }
//
//       return Container(
//         padding: EdgeInsets.all(AppDimensions.paddingLG),
//         decoration: BoxDecoration(
//           color: AppColors.white,
//           borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//         ),
//         child: Column(
//           children: [
//             Container(
//               width: 100.w,
//               height: 100.w,
//               decoration: BoxDecoration(
//                 color: AppColors.grey100,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.person,
//                 size: 50.w,
//                 color: AppColors.textTertiary,
//               ),
//             ),
//             SizedBox(height: AppDimensions.paddingMD),
//             Text(doctor.firstName, style: AppTextStyles.h5),
//             SizedBox(height: 4.h),
//             Text(
//               doctor.specialty,
//               style: AppTextStyles.bodyMedium.copyWith(
//                 color: AppColors.textSecondary,
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
//
//   Widget _buildReviewSection() {
//     return Container(
//       padding: EdgeInsets.all(AppDimensions.paddingLG),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//       ),
//       child: Column(
//         children: [
//           Text(
//             'How was your experience\nwith Dr. Marvin Boeson',
//             style: AppTextStyles.bodyLarge.copyWith(
//               fontWeight: FontWeight.w500,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: AppDimensions.paddingLG),
//           Obx(
//             () => RatingBar.builder(
//               initialRating: controller.rating.value,
//               minRating: 1,
//               direction: Axis.horizontal,
//               allowHalfRating: false,
//               itemCount: 5,
//               itemSize: 45.w,
//               unratedColor: AppColors.grey200,
//               itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
//               itemBuilder: (context, index) {
//                 return const Icon(Icons.star, color: AppColors.primary);
//               },
//               onRatingUpdate: controller.onRatingChanged,
//             ),
//           ),
//           SizedBox(height: AppDimensions.paddingXL),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'Write Your Review',
//               style: AppTextStyles.bodyLarge.copyWith(
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           SizedBox(height: AppDimensions.paddingMD),
//           Container(
//             decoration: BoxDecoration(
//               color: AppColors.grey50,
//               borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
//               border: Border.all(color: AppColors.border),
//             ),
//             child: TextField(
//               controller: controller.reviewController,
//               maxLines: 6,
//               style: AppTextStyles.bodyMedium,
//               decoration: InputDecoration(
//                 hintText: 'Your review here...',
//                 hintStyle: AppTextStyles.bodyMedium.copyWith(
//                   color: AppColors.textTertiary,
//                 ),
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.all(AppDimensions.paddingMD),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildButtons() {
//     return Row(
//       children: [
//         Expanded(
//           child: CustomButton(
//             text: AppStrings.cancel,
//             onPressed: controller.onCancel,
//             isOutlined: true,
//           ),
//         ),
//         SizedBox(width: AppDimensions.paddingMD),
//         Expanded(
//           child: CustomButton(
//             text: AppStrings.submit,
//             onPressed: controller.onSubmit,
//           ),
//         ),
//       ],
//     );
//   }
// }
