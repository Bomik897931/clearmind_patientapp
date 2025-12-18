import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../controllers/add_card_controller.dart';
import '../widgets/card_display.dart';

class AddCardScreen extends GetView<AddCardController> {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar:  CustomAppBar(title: AppStrings.addNewCard),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppDimensions.paddingMD),
              child: Column(
                children: [
                  const CardDisplay(
                    balance: '\$ 3,403.09',
                    cardNumber: '**** **** **** 2638',
                    cardHolder: 'Martines',
                    expiryDate: '04/25',
                  ),
                  SizedBox(height: AppDimensions.paddingLG),
                  CustomTextField(
                    labelText: AppStrings.cardName,
                    controller: controller.cardNameController,
                    hintText: 'Andrew Ainsley',
                  ),
                  SizedBox(height: AppDimensions.paddingMD),
                  CustomTextField(
                    labelText: AppStrings.cardNumber,
                    controller: controller.cardNumberController,
                    hintText: '2657 4568 2568 4589',
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: AppDimensions.paddingMD),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          labelText: AppStrings.expiryDate,
                          controller: controller.expiryDateController,
                          hintText: '08/06/22',
                          suffixIcon: const Icon(Icons.calendar_today),
                        ),
                      ),
                      SizedBox(width: AppDimensions.paddingMD),
                      Expanded(
                        child: CustomTextField(
                          labelText: AppStrings.cvv,
                          controller: controller.cvvController,
                          hintText: '858',
                          keyboardType: TextInputType.number,
                          obscureText: true,
                        ),
                      ),
                    ],
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
