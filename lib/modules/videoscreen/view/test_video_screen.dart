import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/simple_call_service.dart';
import '../../Auth/controllers/auth_controller.dart';

class TestVideoScreen extends StatelessWidget {
  const TestVideoScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final authController = Get.find<AuthController>();
//     final callService = Get.find<SimpleCallService>();
//     final channelController = TextEditingController();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Video Call App'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () => authController.logout(),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // User Info Card
//             Obx(
//               () => Card(
//                 elevation: 2,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       CircleAvatar(
//                         radius: 40,
//                         backgroundColor: Theme.of(context).primaryColor,
//                         child: Text(
//                           authController.currentUser.value?.name
//                                   .substring(0, 1)
//                                   .toUpperCase() ??
//                               'U',
//                           style: const TextStyle(
//                             fontSize: 32,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         authController.currentUser.value?.name ?? 'User',
//                         style: Theme.of(context).textTheme.titleLarge,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 32),
//
//             // Start Video Call Section
//             Text(
//               'Start a Video Call',
//               style: Theme.of(
//                 context,
//               ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//
//             TextField(
//               controller: channelController,
//               decoration: InputDecoration(
//                 labelText: 'Channel Name',
//                 hintText: 'Enter channel name',
//                 prefixIcon: const Icon(Icons.video_call),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             SizedBox(
//               height: 50,
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   if (channelController.text.trim().isEmpty) {
//                     Get.snackbar('Error', 'Please enter channel name');
//                     return;
//                   }
//                   Get.toNamed(
//                     '/video-call',
//                     arguments: {'channelName': channelController.text.trim()},
//                   );
//                 },
//                 icon: const Icon(Icons.videocam),
//                 label: const Text('Join Call', style: TextStyle(fontSize: 16)),
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 32),
//
//             // TEST BUTTONS (for testing incoming call)
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.orange.shade50,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.orange.shade200),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.science, color: Colors.orange.shade700),
//                       const SizedBox(width: 8),
//                       Text(
//                         'Test Incoming Call',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.orange.shade700,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   const Text(
//                     'Simulate receiving a call from another user:',
//                     style: TextStyle(fontSize: 14),
//                   ),
//                   const SizedBox(height: 12),
//
//                   // Test button
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       // Simulate incoming call
//                       callService.showIncomingCall(
//                         callerName: 'John Doe',
//                         channelName:
//                             'test-channel-${DateTime.now().millisecondsSinceEpoch}',
//                       );
//                     },
//                     icon: const Icon(Icons.phone_in_talk),
//                     label: const Text('Simulate Incoming Call'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.orange,
//                       foregroundColor: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             // Instructions
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade50,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.info_outline, color: Colors.blue.shade700),
//                       const SizedBox(width: 8),
//                       Text(
//                         'How to Test',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue.shade700,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     '1. Click "Simulate Incoming Call"\n'
//                     '2. You\'ll hear ringtone + vibration\n'
//                     '3. Click "Accept" to join call\n'
//                     '4. Or click "Decline" to reject',
//                     style: TextStyle(color: Colors.blue.shade900, height: 1.6),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    final channelController = TextEditingController(text: 'test-channel');

    return Scaffold(
      appBar: AppBar(title: const Text('Quick Video Test')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.videocam, size: 80, color: Colors.blue),
              const SizedBox(height: 24),
              const Text(
                'Agora Video Test',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 48),
              TextField(
                controller: channelController,
                decoration: InputDecoration(
                  labelText: 'Channel Name',
                  hintText: 'Enter channel name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (channelController.text.trim().isEmpty) {
                      Get.snackbar('Error', 'Enter channel name');
                      return;
                    }
                    Get.toNamed(
                      '/video-call',
                      arguments: {'channelName': channelController.text.trim()},
                    );
                  },
                  child: const Text(
                    'Join Call',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.orange.shade700),
                        const SizedBox(width: 8),
                        Text(
                          'Test Instructions',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '1. Enter channel name (e.g., "test-123")\n'
                      '2. Open app on another device\n'
                      '3. Use SAME channel name\n'
                      '4. Both users will connect!',
                      style: TextStyle(
                        color: Colors.orange.shade900,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
