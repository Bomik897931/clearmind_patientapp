import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget _dialogHeader(String title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => Get.back(),
      ),
    ],
  );
}