import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/constants/app_text_style.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../controllers/help_controller.dart';

class HelpScreen extends GetView<HelpController> {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar:  CustomAppBar(title: AppStrings.help),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMessageBox(),
            SizedBox(height: AppDimensions.paddingLG),
            _buildInfoBox(),
            SizedBox(height: AppDimensions.paddingXL),
            CustomButton(
              text: AppStrings.sendMail,
              onPressed: controller.onSendMail,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBox() {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Message',
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppDimensions.paddingMD),
          Container(
            decoration: BoxDecoration(
              color: AppColors.grey50,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
              border: Border.all(color: AppColors.border),
            ),
            child: TextField(
              controller: controller.messageController,
              maxLines: 8,
              style: AppTextStyles.bodyMedium,
              decoration: InputDecoration(
                hintText:
                    'Hi I need your help, I can\'t use this app. Can you send me tutorial "How can I use this app" Thank you...',
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textTertiary,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(AppDimensions.paddingMD),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingLG),
      decoration: BoxDecoration(
        color: AppColors.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        border: Border.all(color: AppColors.info.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: AppColors.info,
            size: AppDimensions.iconMD,
          ),
          SizedBox(width: AppDimensions.paddingMD),
          Expanded(
            child: Text(
              'Fill out the form above to send an email and one of our team members will address your question or issue as soon as possible.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
