// // lib/modules/consultation/views/video_call_screen.dart

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:patient_app/core/constants/app_text_style.dart';
// import '../../../core/constants/app_colors.dart';
// import '../../../core/constants/app_dimensions.dart';
// import '../controllers/video_call_controller.dart';

// class VideoCallScreen extends GetView<VideoCallController> {
//   const VideoCallScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.black,
//       body: Stack(
//         children: [
//           // Main video feed
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             color: AppColors.grey800,
//             child: Center(
//               child: Icon(
//                 Icons.person,
//                 size: 120.w,
//                 color: AppColors.white.withOpacity(0.3),
//               ),
//             ),
//           ),

//           // Top bar
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               padding: EdgeInsets.only(
//                 top: MediaQuery.of(context).padding.top,
//                 left: AppDimensions.paddingMD,
//                 right: AppDimensions.paddingMD,
//                 bottom: AppDimensions.paddingMD,
//               ),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     AppColors.black.withOpacity(0.7),
//                     Colors.transparent,
//                   ],
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back, color: AppColors.white),
//                     onPressed: () => Get.back(),
//                   ),
//                   const Spacer(),
//                   Container(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: AppDimensions.paddingSM,
//                       vertical: 4.h,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColors.black.withOpacity(0.5),
//                       borderRadius: BorderRadius.circular(
//                         AppDimensions.radiusSM,
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(
//                           Icons.lock,
//                           color: AppColors.white,
//                           size: 12,
//                         ),
//                         SizedBox(width: 4.w),
//                         Text(
//                           'End-to-end Encrypted',
//                           style: AppTextStyles.caption.copyWith(
//                             color: AppColors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Spacer(),
//                   IconButton(
//                     icon: const Icon(Icons.more_vert, color: AppColors.white),
//                     onPressed: () {},
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Center info
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'John Smith',
//                   style: AppTextStyles.h4.copyWith(color: AppColors.white),
//                 ),
//                 SizedBox(height: AppDimensions.paddingSM),
//                 Obx(
//                   () => Text(
//                     controller.callDuration.value.toString(),
//                     style: AppTextStyles.bodyMedium.copyWith(
//                       color: AppColors.white.withOpacity(0.7),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Bottom controls
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               padding: EdgeInsets.all(AppDimensions.paddingLG),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.topCenter,
//                   colors: [
//                     AppColors.black.withOpacity(0.7),
//                     Colors.transparent,
//                   ],
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Obx(
//                     () => _buildControlButton(
//                       icon: controller.isMuted.value
//                           ? Icons.mic_off
//                           : Icons.mic,
//                       onTap: controller.toggleMute,
//                     ),
//                   ),
//                   Obx(
//                     () => _buildControlButton(
//                       icon: controller.isVideoOff.value
//                           ? Icons.videocam_off
//                           : Icons.videocam,
//                       onTap: controller.toggleVideo,
//                     ),
//                   ),
//                   _buildControlButton(
//                     icon: Icons.call_end,
//                     onTap: controller.endCall,
//                     backgroundColor: AppColors.error,
//                   ),
//                   _buildControlButton(
//                     icon: Icons.flip_camera_ios,
//                     onTap: () {},
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildControlButton({
//     required IconData icon,
//     required VoidCallback onTap,
//     Color? backgroundColor,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         width: 56.w,
//         height: 56.w,
//         decoration: BoxDecoration(
//           color: backgroundColor ?? AppColors.white.withOpacity(0.2),
//           shape: BoxShape.circle,
//         ),
//         child: Icon(icon, color: AppColors.white, size: AppDimensions.iconMD),
//       ),
//     );
//   }
// }
