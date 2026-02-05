import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashController = Get.find<SplashController>();
    return Scaffold(
      backgroundColor: AppColors.extraPrimaryLight,
      body: SafeArea(
        child: Center(
          child: Image.asset(Assets.CMPng, height: 111, width: 204),
          // SvgPicture.asset(Assets.CMSplash, height: 111, width: 204),
        ),
      ),
    );
  }
}
