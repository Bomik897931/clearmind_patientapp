import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

var height = Get.height;
var width = Get.width;

/// Used for TERMINATED notification handling
RemoteMessage? initialMessage;

/// Used for notification-based navigation
String? pendingRoute;
dynamic pendingArgs;
