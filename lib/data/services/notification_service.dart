import 'dart:convert';
import 'dart:io';
import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:patient_app/ma_test_screen/notification_screen.dart';

import '../../core/routes/app_routes.dart';

class NotificationServices {
  // import 'dart:convert';
  // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
  // import 'package:firebase_messaging/firebase_messaging.dart';
  // import 'package:get/get.dart';

  static final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  Future<void> init() async {
    await _requestPermission();
    await _initLocalNotification();
    _getFCMToken();
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
  void _getFCMToken() async {
    String? token = await _firebaseMessaging.getToken();
    print("FCM TOKEN: $token");

    // 👉 send this token to backend API
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

  /*// for accessing firebase message notification (push notification)
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  ///for getting firebase messaging token
  Future<String?> getFirebaseMessagingToken() async {
    try {
      String? token = await fMessaging.getToken();
      if (token != null) {
        // setStringData('deviceToken', token);
        log('Device Token: $token');
        return token;
      }
      log('Device Token can not find');
      return null;
    } catch (e) {
      log('FCM Token error: $e');
      return null;
    }
  }

  ///Get permission from user for notification
  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await fMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('Notification Allow');
    } else {
      Get.snackbar(
        "Notification Permission Denied",
        "Please allow notification from app setting for notification",
        // backgroundColor: AppColor.primary,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  ///initialize Local Notification Plugins
  void initLocalNotification(RemoteMessage message) async {
    var androidInitSetting = const AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    var iosInitSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
      android: androidInitSetting,
      iOS: iosInitSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (payroll) {
        handleMessage(message);
      },
    );
  }

  /// firebase initialization (When app is in running state)
  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      // AndroidNotification? android = message.notification!.android;
      if (kDebugMode) {
        print('Title: ${notification!.title}');
        print('Body: ${notification.body}');
      }

      if (Platform.isAndroid) {
        initLocalNotification(message);
        showNotification(message);
        // handleMessage(message);
      } else if (Platform.isIOS) {
        iosForegroundMessage();
      }
    });
    setUpInteractMessage();
  }

  ///function to show notification
  Future<void> showNotification(RemoteMessage message) async {
    //channel settings
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      description: 'Demo channel Description',
      importance: Importance.high,
      showBadge: true,
      playSound: true,
      enableVibration: true,
    );

    //android settings
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          playSound: channel.playSound,
          importance: channel.importance,
          priority: Priority.high,
          sound: channel.sound,
          icon: '@mipmap/ic_launcher',
          // styleInformation: BigTextStyleInformation(''),
          //for show all text not ...
          styleInformation: BigTextStyleInformation(
            message.notification!.body ?? "",
            contentTitle: message.notification!.title,
            // htmlFormatBigText: true,
            htmlFormatBigText: false,
          ),
        );

    //ios settings
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

    //merging both setting
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    //show Notification
    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
        payload: "This is my notification data",
      );
    });
  }

  ///when app is in background and terminate state
  Future<void> setUpInteractMessage() async {
    //backGround State
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(message);
    });

    //terminate State
    FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message,
    ) {
      if (message != null && message.data.isNotEmpty) {
        handleMessage(message);
      }
    });
  }

  ///handler for handle message
  Future<void> handleMessage(RemoteMessage message) async {
    // Get.to(() => FavoriteDoctorsScreen());
    Get.toNamed(AppRoutes.FAVORITE_DOCTORS);
    // if (message.data['Screen'] == 'OrderReceivedScreen') {
    //   // Get.to(() => OrderReceivedScreen());
    // } else {
    //   // Get.offAll(() => SplashScreen());
    // }

    /// can go to notification screen with message and show the notification data on that screen
  }

  // for ios message
  Future iosForegroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  ///getDeviceTokensByDealerOrLocation

  // Future<String?> getDeviceTokenFromFirebase({
  //   String? dealerId,
  //   String? locationId,
  // }) async {
  //   Query query = FirebaseFirestore.instance.collection('users');
  //
  //   if (dealerId != null) {
  //     query = query.where('dealerid', isEqualTo: dealerId);
  //   } else if (locationId != null) {
  //     query = query.where('locationids', arrayContains: locationId);
  //   }
  //
  //   final snapshot = await query.get();
  //   String? token;
  //
  //   for (var doc in snapshot.docs) {
  //     token = doc['token'];
  //     if (token != null && token.isNotEmpty) {
  //       return token;
  //     }
  //   }
  //   return null;
  // }

  // Future<List<Map<String, dynamic>>> fetchNotifications(String tCode) async {
  //   final snapshot = await FirebaseFirestore.instance
  //       .collection('notifications')
  //       .doc(tCode)
  //       .collection('userNotifications')
  //       .orderBy('sendAt', descending: true)
  //       .get();
  //
  //   return snapshot.docs.map((doc) {
  //     return {
  //       'id': doc.id,
  //       ...doc.data(),
  //     };
  //   }).toList();
  // }*/
}
