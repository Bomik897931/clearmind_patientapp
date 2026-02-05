import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../widgets/textWidget.dart';

class Thirdonboardview extends StatefulWidget {
  const Thirdonboardview({super.key});

  @override
  State<Thirdonboardview> createState() => _ThirdonboardviewState();
}

class _ThirdonboardviewState extends State<Thirdonboardview> {
  int currentIndex = 2;

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
            SizedBox(height: screenHeight * 55 / referenceHeight),
            SvgPicture.asset(Assets.thirdOnboard, height: 273, width: 233),
            SizedBox(height: screenHeight * 78 / referenceHeight),
            Container(
              height: screenHeight * 205 / referenceHeight,
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  mediumtext(
                    text: 'Easy Medicine Delivery',
                    fontsize: 18,
                    color: AppColors.primaryLight,
                  ),
                  SizedBox(height: screenHeight * 16 / referenceHeight),
                  mediumtext(
                    textAlign: TextAlign.center,
                    text:
                        'Easy Medicine Delivery lets you order prescribed medicines quickly and safely from your home. Get timely doorstep delivery so you never miss your medication and stay stress-free.',
                    fontsize: 12,
                    color: AppColors.textSecondary,
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
