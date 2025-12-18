import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/constants/app_text_style.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../controllers/chat_controller.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppColors.grey100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                size: 20.w,
                color: AppColors.textTertiary,
              ),
            ),
            SizedBox(width: AppDimensions.paddingSM),
            Text('John Smith', style: AppTextStyles.h6),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam, color: AppColors.primary),
            onPressed: () => Get.toNamed('/video-call'),
          ),
          IconButton(
            icon: const Icon(Icons.call, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: EdgeInsets.all(AppDimensions.paddingMD),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  if (message['isSystem'] == true) {
                    return _buildSystemMessage(message['text']);
                  }
                  return _buildMessage(message);
                },
              ),
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildSystemMessage(String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppDimensions.paddingSM),
      padding: EdgeInsets.all(AppDimensions.paddingSM),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
      ),
      child: Row(
        children: [
          const Icon(Icons.lock, size: 16, color: AppColors.warning),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.caption.copyWith(color: AppColors.warning),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    final isSent = message['isSent'] ?? false;
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: AppDimensions.paddingSM),
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        constraints: BoxConstraints(maxWidth: 250.w),
        decoration: BoxDecoration(
          color: isSent ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message['text'],
              style: AppTextStyles.bodyMedium.copyWith(
                color: isSent ? AppColors.white : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message['time'],
                  style: AppTextStyles.caption.copyWith(
                    color: isSent
                        ? AppColors.white.withOpacity(0.7)
                        : AppColors.textTertiary,
                  ),
                ),
                if (isSent) ...[
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.done_all,
                    size: 14.w,
                    color: AppColors.white.withOpacity(0.7),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
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
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.add, color: AppColors.primary),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: controller.messageController,
              decoration: InputDecoration(
                hintText: 'Type a message',
                border: InputBorder.none,
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.attach_file, color: AppColors.primary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt, color: AppColors.primary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.mic, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
