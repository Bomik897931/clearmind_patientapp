import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:patient_app/modules/videoscreen/controller/video_call_controller.dart';


class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final VideoCallController controller = Get.put(VideoCallController());
  String? channelName;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    channelName = args?['channelName'];
    if (channelName != null) {
      controller.joinCall(channelName!);
    }
  }

  @override
  void dispose() {
    controller.leaveCall();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
      return const Center(child: CircularProgressIndicator(color: Colors.white));
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
                color: Colors.black87,
                child: const Center(
                  child: Icon(Icons.videocam_off, size: 48, color: Colors.white),
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
            color: Colors.black87,
            child: const Center(
              child: Icon(Icons.videocam_off, size: 80, color: Colors.white),
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
            colors: [Colors.black.withOpacity(0.7), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.video_call, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(channelName ?? 'Video Call', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  Obx(() => Text(controller.getFormattedDuration(), style: const TextStyle(color: Colors.white70))),
                ],
              ),
            ),
            Obx(() => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: controller.isCallConnected.value ? Colors.green : Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                controller.isCallConnected.value ? 'Connected' : 'Connecting...',
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
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
            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
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
              backgroundColor: controller.isMuted.value ? Colors.red : Colors.white24,
            )),
            Obx(() => _buildControlButton(
              icon: controller.isVideoEnabled.value ? Icons.videocam : Icons.videocam_off,
              label: controller.isVideoEnabled.value ? 'Stop Video' : 'Start Video',
              onPressed: controller.toggleVideo,
              backgroundColor: controller.isVideoEnabled.value ? Colors.white24 : Colors.red,
            )),
            _buildControlButton(
              icon: Icons.call_end,
              label: 'End',
              onPressed: () {
                controller.leaveCall();
                Get.back();
              },
              backgroundColor: Colors.red,
              iconSize: 32,
            ),
            _buildControlButton(
              icon: Icons.flip_camera_android,
              label: 'Flip',
              onPressed: controller.switchCamera,
              backgroundColor: Colors.white24,
            ),
            Obx(() => _buildControlButton(
              icon: controller.isSpeakerEnabled.value ? Icons.volume_up : Icons.volume_off,
              label: 'Speaker',
              onPressed: controller.toggleSpeaker,
              backgroundColor: controller.isSpeakerEnabled.value ? Colors.white24 : Colors.grey,
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
            child: Icon(icon, color: Colors.white, size: iconSize),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
