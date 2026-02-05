import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../widgets/textWidget.dart';

class FirstOnboard extends StatefulWidget {
  const FirstOnboard({super.key});

  @override
  State<FirstOnboard> createState() => _FirstOnboardState();
}

class _FirstOnboardState extends State<FirstOnboard> {
  final CarouselController _controller = CarouselController();
  int currentIndex = 0;

  final List<String> _images = [
    Assets.onboardImgOneS,
    Assets.secondOnboard,
    Assets.thirdOnboard,
    Assets.fourthOnboard,
  ];

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
            SvgPicture.asset(Assets.onboardImgOneS, height: 225, width: 225),
            SizedBox(height: screenHeight * 24 / referenceHeight),
            Container(
              padding: EdgeInsets.only(
                top: 16,
                right: 16,
                left: 16,
                bottom: 16,
              ),
              height: screenHeight * 373 / referenceHeight,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  mediumtext(
                    text: "Psychiatrist",
                    fontsize: 18,
                    color: AppColors.primaryLight,
                  ),

                  SizedBox(height: screenHeight * 10 / referenceHeight),
                  mediumtext(
                    textAlign: TextAlign.center,
                    text:
                        "Psychiatrists Diagnose And Treat Mental Health Disorders Using Medication And Therapy",
                    fontsize: 12,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: screenHeight * 16 / referenceHeight),
                  dottedDivider(),
                  SizedBox(height: screenHeight * 16 / referenceHeight),
                  mediumtext(
                    text: "Psychologist",
                    fontsize: 18,
                    color: AppColors.primaryLight,
                  ),

                  SizedBox(height: screenHeight * 10 / referenceHeight),
                  mediumtext(
                    textAlign: TextAlign.center,
                    text:
                        'Psychologists Help People Manage Thoughts, Emotions, And Behavior For Better Well-Being',
                    fontsize: 12,
                    color: AppColors.textSecondary,
                  ),

                  SizedBox(height: screenHeight * 16 / referenceHeight),
                  dottedDivider(),
                  SizedBox(height: screenHeight * 16 / referenceHeight),
                  mediumtext(
                    text: "Therapist",
                    fontsize: 18,
                    color: AppColors.primaryLight,
                  ),

                  SizedBox(height: screenHeight * 10 / referenceHeight),
                  mediumtext(
                    textAlign: TextAlign.center,
                    text:
                        'Therapists Help People Cope With Emotional, Mental, And Behavioral Challenges',
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

        child: const SizedBox(width: double.infinity, height: 0),
      ),
    );
  }
}

// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:patient_app/core/constants/app_assets.dart';
// import 'package:patient_app/core/constants/app_colors.dart';

// class FirstOnboard extends StatefulWidget {
//   const FirstOnboard({super.key});

//   @override
//   State<FirstOnboard> createState() => _FirstOnboardState();
// }

// class _FirstOnboardState extends State<FirstOnboard> {
//   int currentIndex = 0;

//   final List<Map<String, String>> _professionalInfo = [
//     {
//       'title': 'Psychiatrist',
//       'description':
//           'Psychiatrists Diagnose And Treat Mental Health Disorders Using Medication And Therapy',
//     },
//     {
//       'title': 'Psychologist',
//       'description':
//           'Psychologists Help People Manage Thoughts, Emotions, And Behavior For Better Well-Being',
//     },
//     {
//       'title': 'Therapist',
//       'description':
//           'Therapists Help People Cope With Emotional, Mental, And Behavioral Challenges',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: AppColors.extraPrimaryLight,
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(minHeight: constraints.maxHeight),
//                 child: IntrinsicHeight(
//                   child: Column(
//                     children: [
//                       SizedBox(height: screenHeight * 0.03),

//                       // Logo/Header
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: SvgPicture.asset(
//                           Assets.onboardImgOneS,
//                           height: screenHeight * 0.25,
//                           width: screenWidth * 0.6,
//                           fit: BoxFit.contain,
//                         ),
//                       ),

//                       SizedBox(height: screenHeight * 0.03),

//                       // White Container with flexible height
//                       Flexible(
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//                           child: Container(
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: AppColors.white,
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: SingleChildScrollView(
//                               physics: NeverScrollableScrollPhysics(),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(20),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     // Build professional info sections
//                                     ..._professionalInfo.asMap().entries.map((
//                                       entry,
//                                     ) {
//                                       int index = entry.key;
//                                       Map<String, String> info = entry.value;

//                                       return Column(
//                                         children: [
//                                           _buildInfoSection(
//                                             info['title']!,
//                                             info['description']!,
//                                           ),
//                                           if (index <
//                                               _professionalInfo.length - 1)
//                                             Column(
//                                               children: [
//                                                 SizedBox(height: 16),
//                                                 // _dottedDivider(),
//                                                 SizedBox(height: 16),
//                                               ],
//                                             ),
//                                         ],
//                                       );
//                                     }),

//                                     SizedBox(height: 20),

//                                     // Pagination Dots
//                                     _buildPaginationDots(),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoSection(String title, String description) {
//     return Column(
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             color: AppColors.primaryLight,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 8),
//         Text(
//           description,
//           textAlign: TextAlign.center,
//           style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
//         ),
//       ],
//     );
//   }

//   // Widget _dottedDivider() {
//   //   return DottedBorder(
//   //     dashPattern: [6, 5],
//   //     strokeWidth: 1.5,
//   //     color: AppColors.grey200,
//   //     padding: EdgeInsets.zero,
//   //     child: const SizedBox(width: double.infinity, height: 0),
//   //   );
//   // }

//   Widget _buildPaginationDots() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(
//         4,
//         (index) => Container(
//           margin: EdgeInsets.symmetric(horizontal: 4),
//           width: 8,
//           height: 8,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: index == currentIndex
//                 ? AppColors.primaryLight
//                 : AppColors.grey200,
//           ),
//         ),
//       ),
//     );
//   }
// }
