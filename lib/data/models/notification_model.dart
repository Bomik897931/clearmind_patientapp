import 'package:flutter/material.dart';

class NotificationModel {
  final int notificationId;
  final String type;
  final int? appointmentId;
  final int? prescriptionId;
  final int? ticketId;
  final int receiverUserId;
  final int senderUserId;
  final String title;
  final String message;
  final bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.notificationId,
    required this.type,
    this.appointmentId,
    this.prescriptionId,
    this.ticketId,
    required this.receiverUserId,
    required this.senderUserId,
    required this.title,
    required this.message,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['notificationId'] ?? 0,
      type: json['type'] ?? '',
      appointmentId: json['appointmentId'],
      prescriptionId: json['prescriptionId'],
      ticketId: json['ticketId'],
      receiverUserId: json['receiverUserId'] ?? 0,
      senderUserId: json['senderUserId'] ?? 0,
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      isRead: json['isRead'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  IconData get icon {
    switch (type.toLowerCase()) {
      case 'appointment':
        return Icons.calendar_today;
      case 'prescription':
        return Icons.medical_services;
      case 'ticket':
        return Icons.confirmation_number;
      case 'reschedule':
        return Icons.event_repeat;
      case 'reminder':
        return Icons.access_time;
      default:
        return Icons.notifications;
    }
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else {
      return '${(difference.inDays / 7).floor()}w';
    }
  }

  String get dateGroup {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final notificationDate = DateTime(
      createdAt.year,
      createdAt.month,
      createdAt.day,
    );

    final difference = now.difference(createdAt);

    if (notificationDate == today) {
      return 'Today';
    } else if (notificationDate == yesterday) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return 'This Week';
    } else {
      return 'Earlier';
    }
  }
}