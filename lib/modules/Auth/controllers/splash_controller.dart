import 'package:get/get.dart';

import '../../../data/repositories/user_repository.dart';
import '../../../data/services/StorageService.dart';

class SplashController extends GetxController {
  final StorageService _storage;

  SplashController({StorageService? storage})
    : _storage = storage ?? StorageService();

  @override
  void onInit() {
    super.onInit();
    // _checkAuthStatus();
    checkRefreshToken();
  }

  Future<void> _checkAuthStatus() async {
    try {
      // Wait for 2 seconds (splash display time)
      await Future.delayed(const Duration(seconds: 3));
      print('🔵 Splash: Checking auth status...');
      // Check if user is logged in
      final token = await _storage.getToken();
      final user = await _storage.getUser();

      print('Token: ${token != null ? "Found" : "Not found"}');
      print('User: ${user?.email ?? "Not found"}');

      if (token != null && user != null) {
        print('✅ Splash: User logged in, navigating to home');
        Get.offAllNamed('/onboard-view');
      } else {
        print('❌ Splash: User not logged in, navigating to login');
        // Get.offAllNamed('/login');
      }
    } catch (e) {
      print('🔴 Splash: Error checking auth - $e');
      // Get.offAllNamed('/login');
    }
  }

  Future<void> checkRefreshToken() async {
    try {
      final token = await _storage.getToken();
      final user = await _storage.getUser();
      final AuthRepository authRepo = AuthRepository();

      final response = await authRepo.refreshToken(token!);

      if (response!.isValid == true && response.userId != null) {
        print(' Splash: User logged in, navigating to home');
        Get.offAllNamed('/home');
      } else {
        print('❌ Splash: You session has expired, navigating to login');

        Get.offAllNamed('/onboard-view');
      }
    } catch (e) {
      print('🔴 Splash: Error checking auth - $e');
      Get.offAllNamed('/login');
    }
  }
}
