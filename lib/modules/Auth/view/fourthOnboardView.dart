import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../widgets/textWidget.dart';

class Fourthonboardview extends StatefulWidget {
  const Fourthonboardview({super.key});

  @override
  State<Fourthonboardview> createState() => _FourthonboardviewState();
}

class _FourthonboardviewState extends State<Fourthonboardview> {
  int currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    const double referenceHeight = 800;
    return Scaffold(
      extendBodyBehindAppBar: true,

      backgroundColor: AppColors.extraPrimaryLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 56 / referenceHeight),
            SvgPicture.asset(Assets.fourthOnboard, height: 288, width: 251),
            SizedBox(height: screenHeight * 44 / referenceHeight),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              height: screenHeight * 227 / referenceHeight,
              decoration: BoxDecoration(
                color: AppColors.white,
                
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  mediumtext(
                    text: 'Guides & Videos',
                    fontsize: 18,
                    color: AppColors.primaryLight,
                  ),
                  SizedBox(height: screenHeight * 16 / referenceHeight),
                  mediumtext(
                    textAlign: TextAlign.center,
                    text:
                        'Guides and Videos provide easy-to-understand health information through expert-created content. Learn about mental well-being, treatments, and self-care anytime, anywhere.',
                    fontsize: 12,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: screenHeight * 24 / referenceHeight),
                  GestureDetector(
                    onTap: () => Get.toNamed('/login'),
                    child: Container(
                      height: screenHeight * 40 / referenceHeight,
                      width: 216,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: Text("Get Started", style: AppTextStyles.button),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dottedDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          dashPattern: [6, 5],
          strokeWidth: 1.5,
          radius: Radius.circular(0),
          color: AppColors.grey200,
          padding: EdgeInsets.all(0),
        ),

        child: const SizedBox(
          width: double.infinity,
          height: 0, // ✅ thin dotted line
        ),
      ),
    );
  }
}
