import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class NotificationContent extends StatelessWidget {
  final bool isUnread;

  const NotificationContent({super.key, required this.isUnread});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Appointment Reminder",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isUnread ? FontWeight.w600 : FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            if (isUnread)
              Container(
                height: 8,
                width: 8,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          "Your appointment is scheduled for tomorrow at 10:30 AM.",
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 8),
        Text(
          "2 hours ago",
          style: const TextStyle(fontSize: 11, color: AppColors.textTertiary),
        ),
      ],
    );
  }
}
