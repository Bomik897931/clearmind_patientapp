
import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class NotificationIcon extends StatelessWidget {
  final bool isUnread;

  const NotificationIcon({super.key, required this.isUnread});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: isUnread
            ? AppColors.primaryLight
            : AppColors.searchcolor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.notifications,
        color: isUnread
            ? AppColors.textWhite
            : AppColors.textSecondary,
      ),
    );
  }
}
