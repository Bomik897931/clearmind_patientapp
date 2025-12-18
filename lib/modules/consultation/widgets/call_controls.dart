import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

class CallControls extends StatelessWidget {
  final bool isMuted;
  final bool isVideoOff;
  final VoidCallback onMuteToggle;
  final VoidCallback onVideoToggle;
  final VoidCallback onEndCall;
  final VoidCallback onSwitchCamera;

  const CallControls({
    Key? key,
    required this.isMuted,
    required this.isVideoOff,
    required this.onMuteToggle,
    required this.onVideoToggle,
    required this.onEndCall,
    required this.onSwitchCamera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildControlButton(
          icon: isMuted ? Icons.mic_off : Icons.mic,
          onTap: onMuteToggle,
          backgroundColor: isMuted ? AppColors.error : null,
        ),
        _buildControlButton(
          icon: isVideoOff ? Icons.videocam_off : Icons.videocam,
          onTap: onVideoToggle,
          backgroundColor: isVideoOff ? AppColors.error : null,
        ),
        _buildControlButton(
          icon: Icons.call_end,
          onTap: onEndCall,
          backgroundColor: AppColors.error,
          size: 64.w,
        ),
        _buildControlButton(icon: Icons.flip_camera_ios, onTap: onSwitchCamera),
      ],
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
    Color? backgroundColor,
    double? size,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size ?? 56.w,
        height: size ?? 56.w,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.white, size: AppDimensions.iconMD),
      ),
    );
  }
}
