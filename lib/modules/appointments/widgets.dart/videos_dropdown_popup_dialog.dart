import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';

class VideosDropdownPopup extends StatelessWidget {
  final VoidCallback onNewOnlineConsultation;
  final VoidCallback onWhyReally;
  final VoidCallback onWhatIsAnxiety;

  const VideosDropdownPopup({
    super.key,
    required this.onNewOnlineConsultation,
    required this.onWhyReally,
    required this.onWhatIsAnxiety,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMenuItem(
            icon: Icons.play_circle_outline,
            title: 'New Online Consultation Vedio',
            onTap: onNewOnlineConsultation,
            isFirst: true,
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.play_circle_outline,
            title: 'Why Really Happened',
            onTap: onWhyReally,
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.play_circle_outline,
            title: 'What is Anxiety?',
            onTap: onWhatIsAnxiety,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.vertical(
        top: isFirst ? Radius.circular(8.r) : Radius.zero,
        bottom: isLast ? Radius.circular(8.r) : Radius.zero,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20.w,
              color: AppColors.primary,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppColors.grey100,
      indent: 12.w,
      endIndent: 12.w,
    );
  }

  // Static method to show the popup
  static void show(
      BuildContext context, {
        required GlobalKey buttonKey,
        required VoidCallback onNewOnlineConsultation,
        required VoidCallback onWhyReally,
        required VoidCallback onWhatIsAnxiety,
      }) {
    // Get button position
    final RenderBox? renderBox =
    buttonKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox == null) return;

    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx - 220.w + size.width, // Align right edge with button
        offset.dy + size.height + 4.h,  // Below button with small gap
        offset.dx + size.width,
        0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      elevation: 8,
      items: [
        PopupMenuItem(
          enabled: false,
          padding: EdgeInsets.zero,
          child: VideosDropdownPopup(
            onNewOnlineConsultation: () {
              Navigator.pop(context);
              onNewOnlineConsultation();
            },
            onWhyReally: () {
              Navigator.pop(context);
              onWhyReally();
            },
            onWhatIsAnxiety: () {
              Navigator.pop(context);
              onWhatIsAnxiety();
            },
          ),
        ),
      ],
    );
  }
}