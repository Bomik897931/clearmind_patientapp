import 'package:Clarminds/widgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../core/constants/app_assets.dart';
import '../core/constants/app_colors.dart';
import '../modules/home/controller/home_controller.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    const double referenceHeight = 800;

    return Container(
      height: screenHeight * 72 / referenceHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.extraPrimaryLight,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _NavItem(
            index: 0,
            currentIndex: currentIndex,
            icon: Assets.homeIcon,
            label: 'Home',
            onTap: () => _onTap(0),
          ),
          _NavItem(
            index: 1,
            currentIndex: currentIndex,
            icon: Assets.appointmentIcon,
            label: 'Appointments',
            onTap: () => _onTap(1),
          ),
          _NavItem(
            index: 2,
            currentIndex: currentIndex,
            icon: Assets.cartIcon,
            label: 'Cart',
            onTap: () => _onTap(2),
          ),
          _NavItem(
            index: 3,
            currentIndex: currentIndex,
            icon: Assets.profileIcon,
            label: 'Profile',
            onTap: () => _onTap(3),
          ),
        ],
      ),
    );
  }

  // ✅ UPDATED: Only change index, don't navigate
  void _onTap(int index) {
    final controller = Get.find<HomeController>();
    controller.selectedBottomIndex.value = index;

    // ❌ REMOVED: All Get.toNamed() and Get.offAllNamed() calls
    // The IndexedStack in HomeScreen handles switching automatically
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final String icon;
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
      child: Column(
        children: [
          AnimatedContainer(
            height: 30,
            width: 74,
            duration: const Duration(milliseconds: 250),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFBF6D25) : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: SvgPicture.asset(
              icon,
              height: 18,
              width: 18,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: mediumtext(text: label, fontsize: 12)),
        ],
      ),
    );
  }
}