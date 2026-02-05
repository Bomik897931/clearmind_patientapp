import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../widgets/textWidget.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    const double referenceHeight = 800;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SvgPicture.asset(
                    Assets.successCheck,
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: screenHeight * 24 / referenceHeight),
                  mediumtext(text: "Payment Successfully Done", fontsize: 18),
                  SizedBox(height: screenHeight * 8 / referenceHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "10-minute consultation booked with ",
                        style: AppTextStyles.bodySmallGrey,
                      ),
                      mediumtext(
                        text: "Dr. Meera khan",
                        fontsize: 12,
                        color: AppColors.textPrimary,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 16 / referenceHeight),

                  Container(
                    height: screenHeight * 56 / referenceHeight,
                    decoration: BoxDecoration(
                      color: AppColors.grey100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_month_outlined, size: 24),
                              SizedBox(width: 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Date", style: AppTextStyles.bodySmall),
                                  mediumtext(
                                    text: "12/8/2025",
                                    fontsize: 10,
                                    color: AppColors.textSecondary,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.timer_outlined),
                              SizedBox(width: 6),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Time", style: AppTextStyles.bodySmall),
                                  mediumtext(
                                    text: "9 Am To 9:10 Am",
                                    fontsize: 10,
                                    color: AppColors.textSecondary,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 40 / referenceHeight),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 11),
                  height: screenHeight * 40 / referenceHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: Text("Back To Home", style: AppTextStyles.button),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
