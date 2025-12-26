

import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import 'notification_content.dart';
import 'notification_icon.dart';

class NotificationCard extends StatelessWidget {
  final bool isUnread;

  const NotificationCard({super.key, required this.isUnread});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isUnread
              ? AppColors.primary.withOpacity(0.4)
              : Colors.transparent,
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NotificationIcon(isUnread: isUnread),
          const SizedBox(width: 12),
          Expanded(child: NotificationContent(isUnread: isUnread)),
        ],
      ),
    );
  }

}
