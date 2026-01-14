/*
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
            icon: Icons.favorite_border,
            activeIcon: Icons.watch_outlined,
            index: 2,
            onTap: () => Get.toNamed(AppRoutes.FAVORITE_DOCTORS),
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
*/


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/home/controller/home_controller.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4EB),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _NavItem(
            index: 0,
            currentIndex: currentIndex,
            icon: Icons.home,
            label: 'Home',
            onTap: () => _onTap(0),
          ),
          _NavItem(
            index: 1,
            currentIndex: currentIndex,
            icon: Icons.calendar_today,
            label: 'Appointments',
            onTap: () => _onTap(1),
          ),
          _NavItem(
            index: 2,
            currentIndex: currentIndex,
            icon: Icons.shopping_cart,
            label: 'Cart',
            onTap: () => _onTap(2),
          ),
          _NavItem(
            index: 3,
            currentIndex: currentIndex,
            icon: Icons.person_outline,
            label: 'Profile',
            onTap: () => _onTap(3),
          ),
        ],
      ),
    );
  }

  void _onTap(int index) {
    final controller = Get.find<HomeController>();
    controller.selectedBottomIndex.value = index;

    // SAME navigation pattern (update routes if needed)
    switch (index) {
      case 0:
        Get.offAllNamed('/home');
        break;
      case 1:
        Get.toNamed('/my-appointments');
        break;
      case 2:
        Get.toNamed('/cart');
        break;
      case 3:
        Get.toNamed('/profile');
        break;
    }
  }
}


class _NavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavItem({
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == currentIndex;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 18 : 10,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFBF6D25) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? Colors.white : Colors.black,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
