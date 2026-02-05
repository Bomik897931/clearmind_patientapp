import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../widgets/textWidget.dart';

class Secondonboard extends StatefulWidget {
  const Secondonboard({super.key});

  @override
  State<Secondonboard> createState() => _SecondonboardState();
}

class _SecondonboardState extends State<Secondonboard> {
  int currentIndex = 1;

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
            SizedBox(height: screenHeight * 24 / referenceHeight),

            SvgPicture.asset(Assets.secondOnboard, height: 208, width: 184),
            SizedBox(height: screenHeight * 40 / referenceHeight),
            Container(
              child: Column(
                children: [
                  mediumtext(
                    text: "Appointments",
                    fontsize: 18,
                    color: AppColors.primaryLight,
                  ),

                  SizedBox(height: screenHeight * 24 / referenceHeight),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    height: screenHeight * 242 / referenceHeight,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Assets.clockIcon,
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(width: 3),
                            mediumtext(
                              text: '10 minute Consultation',
                              fontsize: 14,
                              color: AppColors.primaryLight,
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 10 / referenceHeight),
                        mediumtext(
                          textAlign: TextAlign.center,
                          text:
                              'Quick consultation for follow-ups, reports discussion, or short concerns. ',
                          fontsize: 12,
                          color: AppColors.textSecondary,
                        ),

                        SizedBox(height: screenHeight * 15 / referenceHeight),

                        dottedDivider(),

                        SizedBox(height: screenHeight * 15 / referenceHeight),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Assets.clockIcon,
                              height: 20,
                              width: 20,
                            ),

                            mediumtext(
                              text: '20 minute Consultation',
                              fontsize: 14,
                              color: AppColors.primaryLight,
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 10 / referenceHeight),
                        mediumtext(
                          textAlign: TextAlign.center,
                          text:
                              'Detailed consultation for therapy sessions, diagnosis discussion, or first-time visits.',
                          fontsize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ],
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

        child: const SizedBox(width: double.infinity, height: 0),
      ),
    );
  }
}
