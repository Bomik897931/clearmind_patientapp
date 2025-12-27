import 'dart:convert';
import 'dart:io';
import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:patient_app/data/repositories/user_repository.dart';
import 'package:patient_app/data/services/StorageService.dart';
import 'package:patient_app/ma_test_screen/notification_screen.dart';

import '../../core/routes/app_routes.dart';

class NotificationServices {

  static final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  final AuthRepository authRepository = AuthRepository();
  final StorageService _storage = StorageService();


  Future<void> init() async {
    await _requestPermission();
    await _initLocalNotification();
    await _getFCMToken();
    _firebaseListeners();
  }

  // 🔐 Permission
  Future<void> _requestPermission() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // 📱 Local Notification Init
  Future<void> _initLocalNotification() async {
    const AndroidInitializationSettings android = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const InitializationSettings settings = InitializationSettings(
      android: android,
    );

    await _local.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        handleNavigationFromPayload(response.payload);
      },
    );
  }

  // 🔑 Get Token
  Future<void> _getFCMToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();

      if (token != null) {
        print("FCM TOKEN: $token");

        // 👉 Register token with backend
        await _registerDeviceToken(token);
      }
    } catch (e) {
      print("Error getting FCM token: $e");
    }

    // 🔄 Listen for token refresh
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      print("FCM TOKEN REFRESHED: $newToken");
      _registerDeviceToken(newToken);
    });
  }

  Future<void> _registerDeviceToken(String devicetoken) async {
    try {
      // Option 1: Using your API service
      final token = await _storage.getToken();
      final platform = Platform.isAndroid ? 'android' : 'ios';
      if (token == null) {
        print(token);
        print("edfghjkl;");
        return;
      }
      await authRepository.registerDevice(token: token!,deviceToken: devicetoken,platform: platform);

      // 👉 Replace the above with your actual API call
      print("Registering token with backend: $token");

    } catch (e) {
      print("Error registering device token: $e");
      // Optionally retry or store locally to retry later
    }
  }

  // 🔁 Listeners
  void _firebaseListeners() {
    // Foreground
    FirebaseMessaging.onMessage.listen((message) {
      _showLocalNotification(message);
    });

    // Background (click)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // _handleNavigation(jsonEncode(message.data));
      handleNavigationFromMessage(message);
    });
  }

  // 🔔 Show Notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await _local.show(
      0,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      details,
      payload: jsonEncode(message.data),
    );
  }

  // 🚀 Navigation
  void handleNavigationFromMessage(RemoteMessage message) {
    _navigate(message.data);
  }

  void handleNavigationFromPayload(String? payload) {
    if (payload == null) return;
    _navigate(jsonDecode(payload));
  }

  void _navigate(Map<String, dynamic> data) {
    // Get.toNamed(AppRoutes.FAVORITE_DOCTORS);
    Get.toNamed(AppRoutes.NOTIFICATIONS);
    // Get.to(()=>NotificationScreen());
    switch (data['type']) {
      case 'order':
        // Get.to(() => OrderScreen(orderId: data['order_id']));
        break;
      case 'chat':
        // Get.to(() => ChatScreen(chatId: data['chat_id']));
        break;
    }
  }


}
