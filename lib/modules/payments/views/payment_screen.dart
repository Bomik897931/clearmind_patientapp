import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/constants/app_text_style.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../controllers/payment_controller.dart';
import '../widgets/payment_method_item.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar:  CustomAppBar(title: AppStrings.payments),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppDimensions.paddingMD),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.selectPaymentMethod,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingLG),
                  Obx(
                    () => Column(
                      children: [
                        PaymentMethodItem(
                          icon: Icons.credit_card,
                          name: 'Mastercard',
                          value: 'mastercard',
                          selectedValue: controller.selectedPaymentMethod.value,
                          onChanged: controller.onPaymentMethodSelected,
                        ),
                        SizedBox(height: AppDimensions.paddingMD),
                        PaymentMethodItem(
                          icon: Icons.credit_card,
                          name: 'RuPay',
                          value: 'rupay',
                          selectedValue: controller.selectedPaymentMethod.value,
                          onChanged: controller.onPaymentMethodSelected,
                        ),
                        SizedBox(height: AppDimensions.paddingMD),
                        PaymentMethodItem(
                          icon: Icons.credit_card,
                          name: 'UPI',
                          value: 'upi',
                          selectedValue: controller.selectedPaymentMethod.value,
                          onChanged: controller.onPaymentMethodSelected,
                        ),
                        SizedBox(height: AppDimensions.paddingMD),
                        PaymentMethodItem(
                          icon: Icons.credit_card,
                          name: 'VISA',
                          value: 'visa',
                          selectedValue: controller.selectedPaymentMethod.value,
                          onChanged: controller.onPaymentMethodSelected,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingLG),
                  CustomButton(
                    text: AppStrings.addNewCard,
                    onPressed: controller.onAddNewCard,
                    isOutlined: true,
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
