import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class SendNotification {

  Future<void> sendPushNotification({
    required String? token, // FCM token of the recipient
    required String? title,
    required String? body,
    Map<String, dynamic>? data,
  }) async {
    log("title: $title, Body: $body");
    try {
      if (token == null) {
        // print('Push token is null');
        return;
      }

      // final serverKey = await GetServerKey().getServerKey(); //comment
      final serverKey = "";
      final uri = Uri.parse(
          'https://fcm.googleapis.com/v1/projects/gainer-app/messages:send');

      final messagePayload = {
        "message": {
          "token": token,
          "notification": {
            "title": title,
            "body": body,
          },
          "data": data,
        }
      };

      final response = await http.post(
        uri,
        headers: {
          "Authorization": "Bearer $serverKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode(messagePayload),
      );

      if (response.statusCode == 200) {
        print('✅ Push notification sent successfully');
        print(response.body);
      } else {
        print('❌ Failed to send notification: ${response.statusCode}');
      }
    } catch (e) {
      print('🚨 Error sending push notification: $e');
    }
  }
}