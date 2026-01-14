import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

import '../../../core/constants/app_colors.dart';
import '../controller/video_call_controller.dart';


class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final VideoCallController controller = Get.put(VideoCallController());
  String? channelName;
  String? appId;
  String? token;
  int? uid;
  int? appointmentId;

  // @override
  // void initState() {
  //   super.initState();
  //   final args = Get.arguments as Map<String, dynamic>?;
  //   channelName = args?['channelName'];
  //   if (channelName != null) {
  //     controller.joinCall(channelName!);
  //   }
  // }

  @override
  void initState() {
    super.initState();

    // Get arguments
    final args = Get.arguments as Map<String, dynamic>?;

    if (args != null) {
      appId = args['appId'];
      channelName = args['channelName'];
      token = args['token'];
      uid = args['uid'] ?? 0;
      appointmentId = args['appointmentId'] ?? 0;

      print('📱 Video Call Arguments:');
      print('App ID: $appId');
      print('Channel: $channelName');
      print('UID: $uid');
      print('appointmentId: $appointmentId');

      // Join call with token
      if (appId != null && channelName != null && token != null) {
        controller.joinCallWithToken(token!, channelName!, appId!, uid!);
      } else {
        Get.snackbar('Error', 'Invalid call parameters');
        Get.back();
      }
    } else {
      Get.snackbar('Error', 'No call parameters provided');
      Get.back();
    }
  }

  @override
  void dispose() {
    controller.leaveCall(appointmentId!);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Obx(() => _buildVideoViews()),
            _buildTopBar(),
            _buildBottomControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoViews() {
    if (!controller.engineInitialized.value) {
      return const Center(child: CircularProgressIndicator(color: AppColors.white));
    }

    if (controller.remoteUid.value != 0) {
      return Column(
        children: [
          Expanded(
            flex: 3,
            child: AgoraVideoView(
              controller: VideoViewController.remote(
                rtcEngine: controller.engine!,
                canvas: VideoCanvas(uid: controller.remoteUid.value),
                connection: RtcConnection(channelId: channelName),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Obx(
                  () => controller.isVideoEnabled.value
                  ? AgoraVideoView(
                controller: VideoViewController(
                  rtcEngine: controller.engine!,
                  canvas: const VideoCanvas(uid: 0),
                ),
              )
                  : Container(
                color: AppColors.black87,
                child: const Center(
                  child: Icon(Icons.videocam_off, size: 48, color: AppColors.white),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Center(
        child: Obx(
              () => controller.isVideoEnabled.value
              ? AgoraVideoView(
            controller: VideoViewController(
              rtcEngine: controller.engine!,
              canvas: const VideoCanvas(uid: 0),
            ),
          )
              : Container(
            color: AppColors.black87,
            child: const Center(
              child: Icon(Icons.videocam_off, size: 80, color: AppColors.white),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildTopBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.black.withOpacity(0.7), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.video_call, color: AppColors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(channelName ?? 'Video Call', style: const TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  Obx(() => Text(controller.getFormattedDuration(), style: const TextStyle(color: AppColors.white70))),
                ],
              ),
            ),
            Obx(() => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: controller.isCallConnected.value ? AppColors.green : AppColors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                controller.isCallConnected.value ? 'Connected' : 'Connecting...',
                style: const TextStyle(color: AppColors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.black.withOpacity(0.8), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(() => _buildControlButton(
              icon: controller.isMuted.value ? Icons.mic_off : Icons.mic,
              label: controller.isMuted.value ? 'Unmute' : 'Mute',
              onPressed: controller.toggleMute,
              backgroundColor: controller.isMuted.value ? AppColors.red : AppColors.white24,
            )),
            Obx(() => _buildControlButton(
              icon: controller.isVideoEnabled.value ? Icons.videocam : Icons.videocam_off,
              label: controller.isVideoEnabled.value ? 'Stop Video' : 'Start Video',
              onPressed: controller.toggleVideo,
              backgroundColor: controller.isVideoEnabled.value ? AppColors.white24 : AppColors.red,
            )),
            _buildControlButton(
              icon: Icons.call_end,
              label: 'End',
              onPressed: () {
                print(appointmentId!);
                controller.leaveCall(appointmentId!);
                // Get.back();
              },
              backgroundColor: AppColors.red,
              iconSize: 32,
            ),
            _buildControlButton(
              icon: Icons.flip_camera_android,
              label: 'Flip',
              onPressed: controller.switchCamera,
              backgroundColor: AppColors.white24,
            ),
            Obx(() => _buildControlButton(
              icon: controller.isSpeakerEnabled.value ? Icons.volume_up : Icons.volume_off,
              label: 'Speaker',
              onPressed: controller.toggleSpeaker,
              backgroundColor: controller.isSpeakerEnabled.value ? AppColors.white24 : Colors.grey,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color backgroundColor,
    double iconSize = 28,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
            child: Icon(icon, color: AppColors.white, size: iconSize),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: AppColors.white, fontSize: 12)),
      ],
    );
  }
}

/*

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:patient_app/modules/videoscreen/controller/video_call_controller.dart';
import '../../../core/constants/app_colors.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final VideoCallController controller = Get.put(VideoCallController());

  String? channelName;
  String? appId;
  String? token;
  int? uid;
  int? appointmentId;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments as Map<String, dynamic>?;

    if (args != null) {
      appId = args['appId'];
      channelName = args['channelName'];
      token = args['token'];
      uid = args['uid'] ?? 0;

      if (appId != null && channelName != null && token != null) {
        controller.joinCallWithToken(token!, channelName!, appId!, uid!);
      } else {
        Get.snackbar('Error', 'Invalid call parameters');
        Get.back();
      }
    } else {
      Get.snackbar('Error', 'No call parameters provided');
      Get.back();
    }
  }

  @override
  void dispose() {
    controller.leaveCall(appointmentId!);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Obx(() {
          if (!controller.engineInitialized.value) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          return Stack(
            children: [
              // Full screen remote user (or local if no remote)
              _buildMainVideo(),

              // Top gradient overlay with info
              _buildTopBar(),

              // Small floating local video (PiP style)
              _buildFloatingLocalVideo(),

              // Bottom controls
              _buildBottomControls(),
            ],
          );
        }),
      ),
    );
  }

  /// Main video (full screen) - Shows remote user or local user
  Widget _buildMainVideo() {
    return Positioned.fill(
      child: Obx(() {
        // If remote user connected, show remote video in full screen
        if (controller.remoteUid.value != 0) {
          return AgoraVideoView(
            controller: VideoViewController.remote(
              rtcEngine: controller.engine!,
              canvas: VideoCanvas(uid: controller.remoteUid.value),
              connection: RtcConnection(channelId: channelName),
            ),
          );
        }
        // Otherwise show local video in full screen (waiting for other user)
        else {
          return controller.isVideoEnabled.value
              ? AgoraVideoView(
            controller: VideoViewController(
              rtcEngine: controller.engine!,
              canvas: const VideoCanvas(uid: 0),
            ),
          )
              : Container(
            color: Colors.black,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.videocam_off,
                    size: 80,
                    color: Colors.white54,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Camera is off',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  /// Floating local video (Picture-in-Picture style) - Only shows when remote user is connected
  Widget _buildFloatingLocalVideo() {
    return Obx(() {
      // Only show floating local video when remote user is connected
      if (controller.remoteUid.value == 0) {
        return const SizedBox.shrink();
      }

      return Positioned(
        top: 100,
        right: 16,
        child: GestureDetector(
          onTap: () {
            // Optional: Add ability to swap views
          },
          child: Container(
            width: 120,
            height: 160,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: controller.isVideoEnabled.value
                  ? AgoraVideoView(
                controller: VideoViewController(
                  rtcEngine: controller.engine!,
                  canvas: const VideoCanvas(uid: 0),
                ),
              )
                  : Container(
                color: Colors.black87,
                child: const Center(
                  child: Icon(
                    Icons.videocam_off,
                    size: 32,
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  /// Top bar with channel info and status
  Widget _buildTopBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0.3),
              Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Back button
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    controller.leaveCall(appointmentId!);
                    Get.back();
                  },
                ),

                const SizedBox(width: 8),

                // Channel name and duration
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        channelName ?? 'Video Call',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Obx(() => Text(
                        controller.getFormattedDuration(),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      )),
                    ],
                  ),
                ),

                // Connection status badge
                Obx(() => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: controller.isCallConnected.value
                        ? Colors.green
                        : Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        controller.isCallConnected.value
                            ? 'Connected'
                            : 'Connecting...',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Bottom controls (WhatsApp style)
  Widget _buildBottomControls() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Mute button
            Obx(() => _buildControlButton(
              icon: controller.isMuted.value ? Icons.mic_off : Icons.mic,
              onPressed: controller.toggleMute,
              backgroundColor: controller.isMuted.value
                  ? Colors.white
                  : Colors.white.withOpacity(0.3),
              iconColor: controller.isMuted.value
                  ? Colors.red
                  : Colors.white,
            )),

            // Video toggle button
            Obx(() => _buildControlButton(
              icon: controller.isVideoEnabled.value
                  ? Icons.videocam
                  : Icons.videocam_off,
              onPressed: controller.toggleVideo,
              backgroundColor: controller.isVideoEnabled.value
                  ? Colors.white.withOpacity(0.3)
                  : Colors.white,
              iconColor: controller.isVideoEnabled.value
                  ? Colors.white
                  : Colors.red,
            )),

            // End call button (larger)
            _buildControlButton(
              icon: Icons.call_end,
              onPressed: () {
                controller.leaveCall(appointmentId!);
                Get.back();
              },
              backgroundColor: Colors.red,
              iconColor: Colors.white,
              size: 70,
              iconSize: 32,
            ),

            // Flip camera button
            _buildControlButton(
              icon: Icons.flip_camera_android,
              onPressed: controller.switchCamera,
              backgroundColor: Colors.white.withOpacity(0.3),
              iconColor: Colors.white,
            ),

            // Speaker button
            Obx(() => _buildControlButton(
              icon: controller.isSpeakerEnabled.value
                  ? Icons.volume_up
                  : Icons.volume_off,
              onPressed: controller.toggleSpeaker,
              backgroundColor: controller.isSpeakerEnabled.value
                  ? Colors.white.withOpacity(0.3)
                  : Colors.white.withOpacity(0.2),
              iconColor: Colors.white,
            )),
          ],
        ),
      ),
    );
  }

  /// Control button widget
  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color iconColor,
    double size = 56,
    double iconSize = 28,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}*/
