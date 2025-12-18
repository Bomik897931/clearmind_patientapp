import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final messageController = TextEditingController();
  final RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void loadMessages() {
    messages.value = [
      {
        'text': 'Messages and calls are end-to-end encrypted...',
        'isSystem': true,
        'time': '2:25 PM',
      },
      {
        'text': 'Hey!! Wanna meet for dinner tonight?',
        'isSent': false,
        'time': '2:27 PM',
      },
      {
        'text': 'Hey!! Wanna meet for dinner tonight?',
        'isSent': true,
        'time': '3:35 PM',
      },
    ];
  }

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    messages.add({
      'text': messageController.text,
      'isSent': true,
      'time': '${DateTime.now().hour}:${DateTime.now().minute}',
    });

    messageController.clear();
  }
}
