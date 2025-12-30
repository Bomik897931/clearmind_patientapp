// lib/modules/splash/controllers/splash_controller.dart
import 'package:get/get.dart';

import '../../../core/constants/constant.dart';
import '../../../core/routes/app_routes.dart';
import '../../../data/services/StorageService.dart';
import '../../../data/services/notification_service.dart';

class SplashController extends GetxController {
  final StorageService _storage;

  SplashController({StorageService? storage})
    : _storage = storage ?? StorageService();

  @override
  void onInit() {
    super.onInit();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    try {
      // Wait for 2 seconds (splash display time)
      await Future.delayed(const Duration(seconds: 3));
      print('🔵 Splash: Checking auth status...');
      // Check if user is logged in
      final token = await _storage.getToken();
      final user = await _storage.getUser();

      // final notificationService = NotificationServices();
      // 🔔 App opened from notification (cold start)
      if (initialMessage != null) {
        print("🔔 Opened from notification");
        Get.offAllNamed('/home');
        Future.delayed(Duration(milliseconds: 100), () {
          Get.toNamed(AppRoutes.NOTIFICATIONS, arguments: initialMessage);
        });
        return;
        // notificationService.handleNavigationFromMessage(initialMessage!);
        // Get.offAllNamed(pendingRoute!, arguments: pendingArgs);
        // Clear after use
        // pendingRoute = null;
        // pendingArgs = null;
      } else {
        print('Token: ${token != null ? "Found" : "Not found"}');
        print('User: ${user?.email ?? "Not found"}');

        if (token != null && user != null) {
          // User is logged in, go to home
          print('✅ Splash: User logged in, navigating to home');
          Get.offAllNamed('/home');
        } else {
          // User not logged in, go to login
          print('❌ Splash: User not logged in, navigating to login');
          Get.offAllNamed('/login');
        }
      }
    } catch (e) {
      print('🔴 Splash: Error checking auth - $e');
      // On error, go to login
      Get.offAllNamed('/login');
    }
  }
}
