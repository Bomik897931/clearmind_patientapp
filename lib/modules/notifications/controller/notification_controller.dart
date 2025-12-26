import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/models/notification_model.dart';
import '../../../data/repositories/notification_repository.dart';
import '../../../data/services/StorageService.dart';

class NotificationController extends GetxController {
  final NotificationRepository _repository;
  final StorageService _storage;

  NotificationController({
    NotificationRepository? repository,
    StorageService? storage,
  })  : _repository = repository ?? NotificationRepository(),
        _storage = storage ?? StorageService();

  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
    // loadDummyNotifications();
  }
 /* void loadDummyNotifications() {
    notifications.value = [
    NotificationModel(
    notificationId: 1,
    title: 'Appointment Successful',
    message: 'Your Appointment Has Been Successfully Booked. We Look Forward To Supporting You And Wish You A Smooth Consultation Experience.',
    type: 'appointment_successful',
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    isRead: false,
    ),
    NotificationModel(
    notificationId: 2,
    title: 'Reschedule Successful',
    message: 'Your Appointment Has Been Successfully Rescheduled. We Appreciate Your Patience And Look Forward To Assisting You At The Updated Time.',
    type: 'reschedule_successful',
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    isRead: false,
    ),
    NotificationModel(
    notificationId: 3,
    title: 'Appointment Reminder',
    message: 'Your Appointment Will Begin In 5 Minutes. Please Be Ready To Join And Ensure Everything Is Set For A Smooth Consultation.',
    type: 'appointment_reminder',
    createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    isRead: false,
    ),
    NotificationModel(
    notificationId: 4,
    title: 'Appointment Successful',
    message: 'Your Appointment Has Been Successfully Booked. We Look Forward To Supporting You And Wish You A Smooth Consultation Experience.',
    type: 'appointment_successful',
    createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    isRead: true,
    ),
    ];
  }*/

    Future<void> loadNotifications() async {
    try {
      isLoading.value = true;

      final token = await _storage.getToken();
      if (token == null) {
        Get.snackbar('Error', 'Please login first');
        Get.offAllNamed('/login');
        return;
      }

      final fetchedNotifications = await _repository.getNotifications(
        token: token,
      );

      notifications.value = fetchedNotifications;
      print('🟢 Loaded ${fetchedNotifications.length} notifications');
    } catch (e) {
      print('🔴 Error loading notifications: $e');
      Get.snackbar(
        'Error',
        'Failed to load notifications',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Map<String, List<NotificationModel>> get groupedNotifications {
    final Map<String, List<NotificationModel>> grouped = {};

    for (var notification in notifications) {
      final group = notification.dateGroup;
      if (!grouped.containsKey(group)) {
        grouped[group] = [];
      }
      grouped[group]!.add(notification);
    }

    return grouped;
  }

  Future<void> onNotificationTap(NotificationModel notification) async {
    // Mark as read
    final token = await _storage.getToken();
    if (token != null) {
      await _repository.markAsRead(
        token: token,
        notificationId: notification.notificationId,
      );
    }

    // Handle navigation based on notification type
    switch (notification.type.toLowerCase()) {
      case 'appointment_successful':
      case 'appointment':
        Get.toNamed('/my-appointments');
        break;
      case 'reschedule':
      case 'reschedule_successful':
        Get.toNamed('/my-appointments');
        break;
      case 'reminder':
      case 'appointment_reminder':
        Get.toNamed('/my-appointments');
        break;
      default:
        break;
    }
  }

  Future<void> refresh() async {
    await loadNotifications();
  }
}