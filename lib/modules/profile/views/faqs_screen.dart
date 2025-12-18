import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/constants/app_text_style.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/custom_app_bar.dart';
import '../controllers/faqs_controller.dart';

class FaqsScreen extends GetView<FaqsController> {
  const FaqsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar:  CustomAppBar(title: AppStrings.faqs),
      body: Obx(
        () => ListView.separated(
          padding: EdgeInsets.all(AppDimensions.paddingMD),
          itemCount: controller.faqs.length,
          separatorBuilder: (context, index) =>
              SizedBox(height: AppDimensions.paddingMD),
          itemBuilder: (context, index) {
            final faq = controller.faqs[index];
            return _buildFAQItem(faq, index);
          },
        ),
      ),
    );
  }

  Widget _buildFAQItem(Map<String, dynamic> faq, int index) {
    final isExpanded = faq['isExpanded'] as bool;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => controller.toggleExpanded(index),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.paddingMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      faq['question'],
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  SizedBox(width: AppDimensions.paddingSM),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 300),
                    turns: isExpanded ? 0.5 : 0,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.primary,
                      size: AppDimensions.iconMD,
                    ),
                  ),
                ],
              ),
              if (isExpanded) ...[
                SizedBox(height: AppDimensions.paddingMD),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: AppColors.divider,
                ),
                SizedBox(height: AppDimensions.paddingMD),
                Text(
                  faq['answer'],
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
