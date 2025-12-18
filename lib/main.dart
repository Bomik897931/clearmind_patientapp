import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';
import 'controller/locale_controller.dart';
import 'data/services/StorageService.dart'; // ← FIXED: Correct path
import 'data/services/api_service.dart';
import 'data/services/simple_call_service.dart';
import 'modules/Auth/controllers/auth_controller.dart';

void main() async {
  // Catch Flutter framework errors FIRST (before runZonedGuarded)
  FlutterError.onError = (FlutterErrorDetails details) {
    print('❌ FLUTTER ERROR: ${details.exception}');
    print('❌ STACK: ${details.stack}');
  };

  runZonedGuarded(
    () async {
      try {
        // CRITICAL: Must be first
        WidgetsFlutterBinding.ensureInitialized();

        print('✅ Starting app initialization...');

        // Initialize GetStorage FIRST (before StorageService)
        await GetStorage.init();
        print('✅ GetStorage initialized');

        // Initialize Storage Service
        final storageService = StorageService();
        await storageService.init();
        Get.put(storageService, permanent: true);
        print('✅ StorageService initialized');

        Get.put(LocaleController(), permanent: true);
        print('✅ LocaleController initialized');

        // Initialize Simple Call Service (NO backend needed!)
        Get.put(SimpleCallService(), permanent: true);
        print('✅ SimpleCallService initialized');

        // Initialize API Service
        final apiService = ApiService();
        // apiService.init();
        // print('✅ ApiService initialized');

        // Initialize Auth Controller
        Get.put(AuthController(), permanent: true);
        print('✅ AuthController initialized');

        // Lock orientation
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        print('✅ Orientation locked');

        print('✅ App initialization complete - Starting MyApp...');

        runApp(const MyApp());
      } catch (e, stack) {
        print('❌ INITIALIZATION ERROR: $e');
        print('❌ STACK TRACE: $stack');

        // Show error screen if initialization fails
        runApp(
          MaterialApp(
            home: Scaffold(
              backgroundColor: Colors.red.shade100,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'App Initialization Failed',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Error: $e',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    },
    (error, stack) {
      print('❌ ZONE ERROR: $error');
      print('❌ ZONE STACK: $stack');
    },
  );
}
