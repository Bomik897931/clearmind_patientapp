import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimensions.dart';
import '../core/routes/app_routes.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.bottomNavBarHeight,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            index: 0,
            onTap: () => Get.offAllNamed(AppRoutes.HOME),
          ),
          _buildNavItem(
            icon: Icons.calendar_today_outlined,
            activeIcon: Icons.calendar_today,
            index: 1,
            onTap: () => Get.toNamed(AppRoutes.MY_APPOINTMENTS),
          ),
          _buildNavItem(
            icon: Icons.watch,
            activeIcon: Icons.watch_outlined,
            index: 2,
            onTap: () => Get.toNamed(AppRoutes.BOOK_SLOT),
          ),
          _buildNavItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            index: 3,
            onTap: () => Get.toNamed(AppRoutes.PROFILE),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required int index,
    required VoidCallback onTap,
  }) {
    final isActive = currentIndex == index;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMD,
          vertical: AppDimensions.paddingSM,
        ),
        child: Icon(
          isActive ? activeIcon : icon,
          color: isActive ? AppColors.primary : AppColors.textTertiary,
          size: AppDimensions.iconLG,
        ),
      ),
    );
  }
}
