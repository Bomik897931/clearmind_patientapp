import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/data/services/simple_call_service.dart';

class IncomingCallScreen extends StatelessWidget {
  const IncomingCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final callerName = args['callerName'] ?? 'Unknown';
    final channelName = args['channelName'] ?? '';
    final callService = Get.find<SimpleCallService>();

    return WillPopScope(
      onWillPop: () async => false, // Prevent back button
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade900,
                Colors.blue.shade700,
                Colors.blue.shade500,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 80),

                // Incoming call text
                const Text(
                  'Incoming Video Call',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                    letterSpacing: 1.5,
                  ),
                ),

                const SizedBox(height: 60),

                // Animated avatar
                _buildAnimatedAvatar(),

                const SizedBox(height: 40),

                // Caller name
                Text(
                  callerName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                // Ringing animation
                Obx(
                  () => TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1000),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: callService.isRinging.value
                            ? (value > 0.5 ? 1.0 : 0.4)
                            : 1.0,
                        child: const Text(
                          'is calling you...',
                          style: TextStyle(color: Colors.white70, fontSize: 20),
                        ),
                      );
                    },
                  ),
                ),

                const Spacer(),

                // Action buttons
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 80,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Decline button
                      _buildActionButton(
                        icon: Icons.call_end,
                        label: 'Decline',
                        color: Colors.red,
                        onPressed: () {
                          callService.rejectCall();
                        },
                      ),

                      const SizedBox(width: 60),

                      // Accept button
                      _buildActionButton(
                        icon: Icons.videocam,
                        label: 'Accept',
                        color: Colors.green,
                        onPressed: () {
                          callService.acceptCall();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedAvatar() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.9, end: 1.1),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 75,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 80, color: Colors.blue.shade900),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            child: Container(
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.6),
                    blurRadius: 25,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 45),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
