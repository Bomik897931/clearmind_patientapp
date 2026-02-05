import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../modules/payments/views/payment_success.dart';
import '../../../widgets/textWidget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    const double referenceHeight = 800;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.extraPrimaryLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 16 / referenceHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Assets.CMPng, height: 26, width: 48),
                  SizedBox(width: 4),
                  mediumtext(
                    text: "CLARMINDS",
                    fontsize: 18,
                    color: AppColors.primary,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 11 / referenceHeight),

              Container(
                height: screenHeight * 746 / referenceHeight,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: Get.back,
                      child: SvgPicture.asset(Assets.backwardArrow),
                    ),
                    SizedBox(height: screenHeight * 24 / referenceHeight),
                    mediumtext(text: "OTP Verification", fontsize: 16),
                    SizedBox(height: screenHeight * 8 / referenceHeight),
                    Text(
                      "Please Enter 6 Digit Codes Send To ",
                      style: AppTextStyles.bodySmallGrey,
                    ),
                    SizedBox(height: screenHeight * 8 / referenceHeight),
                    Text("91+ 6782238203", style: AppTextStyles.bodySmallGrey),
                    SizedBox(height: screenHeight * 24 / referenceHeight),

                    Text("Enter Code", style: AppTextStyles.bodySmall),
                    SizedBox(height: screenHeight * 16 / referenceHeight),
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      autoFocus: false,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black,
                      animationType: AnimationType.scale,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(4),
                        fieldHeight: 48,
                        fieldWidth: 48,
                        activeColor: AppColors.primaryLight,
                        selectedColor: AppColors.primaryLight,
                        inactiveColor: Colors.grey.shade300,

                        activeFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: screenHeight * 24 / referenceHeight),
                    Container(
                      height: screenHeight * 40 / referenceHeight,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.grey100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.grey200),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.timer_outlined, size: 19),
                              SizedBox(
                                width: screenHeight * 8 / referenceHeight,
                              ),
                              mediumtext(text: "Code Expire In", fontsize: 12),
                            ],
                          ),
                          mediumtext(text: "1:00", fontsize: 12),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 16 / referenceHeight),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Didn't Receive The Code ? ",
                          style: AppTextStyles.bodySmallGrey,
                        ),
                        // SizedBox(width: 6),
                        GestureDetector(
                          child: mediumtext(
                            text: "Resend Now",
                            fontsize: 12,
                            color: AppColors.primaryLight,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 40 / referenceHeight),
                    GestureDetector(
                      onTap: () => Get.toNamed('/home'),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 11),
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: mediumtext(
                            text: "Verify Code",
                            fontsize: 12,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 16 / referenceHeight),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Need Help ? ",
                          style: AppTextStyles.bodySmallGrey,
                        ),
                        // SizedBox(width: 6),
                        GestureDetector(
                          onTap: () {
                            Get.to(PaymentSuccessScreen());
                          },
                          child: mediumtext(
                            text: 'Contact Support',
                            fontsize: 12,
                            color: AppColors.primaryLight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
