import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Auth/controllers/auth_controller.dart';

class HomeVCScreen extends StatelessWidget {
  const HomeVCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final channelController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Call App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context, authController),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // User Info Card
            Obx(
              () => Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                          authController.currentUser.value?.fullName
                                  .substring(0, 1)
                                  .toUpperCase() ??
                              'U',
                          style: const TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        authController.currentUser.value?.fullName ?? 'User',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        authController.currentUser.value?.email ?? '',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Join Call Section
            Text(
              'Start a Video Call',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: channelController,
              decoration: InputDecoration(
                labelText: 'Channel Name',
                hintText: 'Enter channel name',
                prefixIcon: const Icon(Icons.video_call),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (channelController.text.trim().isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Please enter a channel name',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }
                  Get.toNamed(
                    '/video-call',
                    arguments: {'channelName': channelController.text.trim()},
                  );
                },
                icon: const Icon(Icons.videocam),
                label: const Text('Join Call', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Quick Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue.shade700),
                      const SizedBox(width: 8),
                      Text(
                        'How to use',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '1. Enter a channel name\n'
                    '2. Click "Join Call" to start\n'
                    '3. Share the channel name with others\n'
                    '4. Anyone with the same channel name can join',
                    style: TextStyle(color: Colors.blue.shade900, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthController authController) {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              authController.logout();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
