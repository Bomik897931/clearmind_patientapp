// import 'package:flutter/material.dart';
// import 'package:patient_app/modules/Auth/view/firstOnboardView.dart';
// import 'package:patient_app/modules/Auth/view/fourthOnboardView.dart';
// import 'package:patient_app/modules/Auth/view/secondOnboardView.dart';
// import 'package:patient_app/modules/Auth/view/thirdOnboardView.dart';

// class OnboardingPage extends StatefulWidget {
//   const OnboardingPage({super.key});

//   @override
//   State<OnboardingPage> createState() => _OnboardingPageState();
// }

// class _OnboardingPageState extends State<OnboardingPage> {
//   final PageController _controller = PageController();
//   int currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _controller,
//         onPageChanged: (index) {
//           setState(() => currentIndex = index);
//         },
//         children: const [
//           FirstOnboard(),
//           Secondonboard(),
//           Thirdonboardview(),
//           Fourthonboardview()
//         ],
//       ),
//     );
//   }
// }
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../modules/Auth/view/firstOnboardView.dart';
import '../../../modules/Auth/view/secondOnboardView.dart';
import '../../../modules/Auth/view/thirdOnboardView.dart';
import '../../../modules/Auth/view/fourthOnboardView.dart';
import '../../../widgets/textWidget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final CarouselSliderController _controller = CarouselSliderController();
  int currentIndex = 0;

  // For REsponsive
  double referenceHeight = 800;
  late final screenHeight = MediaQuery.of(context).size.height;

  final List<Widget> screens = const [
    FirstOnboard(),
    Secondonboard(),
    Thirdonboardview(),
    Fourthonboardview(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.extraPrimaryLight,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 24,
          left: 16,
          right: 16,
          bottom: 60,
        ),
        child: Column(
          children: [
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
            // Center(
            //   child: SvgPicture.asset(Assets.CMSplash, height: 27, width: 152),
            // ),
            Expanded(
              child: CarouselSlider(
                carouselController: _controller,
                items: screens,
                options: CarouselOptions(
                  height: double.infinity,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() => currentIndex = index);
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                screens.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index
                        ? AppColors.primary
                        : Colors.grey.shade400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
