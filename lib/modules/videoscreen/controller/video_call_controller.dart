// import 'dart:async';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:get/get.dart';
// import 'package:patient_app/core/constants/api_constants.dart';
// import 'package:patient_app/data/services/api_service.dart';
// import 'package:permission_handler/permission_handler.dart';

// class VideoCallController extends GetxController {
//   final _apiService = ApiService();

//   RtcEngine? engine;
//   final RxBool isJoined = false.obs;
//   final RxInt remoteUid = 0.obs;
//   final RxBool isMuted = false.obs;
//   final RxBool isVideoEnabled = true.obs;
//   final RxBool isSpeakerEnabled = true.obs;
//   final RxBool isCallConnected = false.obs;

//   String? channelName;
//   int? localUid;
//   String? agoraToken;

//   Timer? _callDurationTimer;
//   final RxInt callDuration = 0.obs;

//   @override
//   void onClose() {
//     _dispose();
//     super.onClose();
//   }

//   Future<void> initializeAgora() async {
//     // Request permissions
//     await [Permission.camera, Permission.microphone].request();

//     // Create Agora engine
//     engine = createAgoraRtcEngine();
//     await engine!.initialize(
//       RtcEngineContext(
//         appId: ApiConstants.agoraAppId,
//         channelProfile: ChannelProfileType.channelProfileCommunication,
//       ),
//     );

//     // Register event handlers
//     engine!.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           print('Local user ${connection.localUid} joined channel');
//           isJoined.value = true;
//           localUid = connection.localUid;
//           _startCallDurationTimer();
//         },
//         onUserJoined: (RtcConnection connection, int uid, int elapsed) {
//           print('Remote user $uid joined');
//           remoteUid.value = uid;
//           isCallConnected.value = true;
//         },
//         onUserOffline:
//             (RtcConnection connection, int uid, UserOfflineReasonType reason) {
//               print('Remote user $uid left channel');
//               remoteUid.value = 0;
//               isCallConnected.value = false;
//             },
//         onLeaveChannel: (RtcConnection connection, RtcStats stats) {
//           print('Left channel');
//           isJoined.value = false;
//           remoteUid.value = 0;
//           isCallConnected.value = false;
//         },
//       ),
//     );

//     // Enable video
//     await engine!.enableVideo();
//     await engine!.startPreview();
//   }

//   Future<void> joinCall(String channel, {String? receiverId}) async {
//     try {
//       channelName = channel;

//       // Get Agora token from backend
//       final tokenData = await _apiService.getAgoraToken(
//         channel,
//         0, // 0 means Agora will assign UID
//       );

//       agoraToken = tokenData['token'];
//       localUid = tokenData['uid'];

//       // Initialize if not already done
//       if (engine == null) {
//         await initializeAgora();
//       }

//       // Join channel
//       await engine!.joinChannel(
//         token: agoraToken!,
//         channelId: channel,
//         uid: localUid!,
//         options: const ChannelMediaOptions(
//           channelProfile: ChannelProfileType.channelProfileCommunication,
//           clientRoleType: ClientRoleType.clientRoleBroadcaster,
//         ),
//       );

//       // Notify backend about call start
//       if (receiverId != null) {
//         await _apiService.startCall(channel, receiverId);
//       }

//       Get.snackbar(
//         'Success',
//         'Joined call successfully',
//         snackPosition: SnackPosition.TOP,
//       );
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to join call: ${e.toString()}',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       print('Error joining call: $e');
//     }
//   }

//   Future<void> leaveCall() async {
//     try {
//       _stopCallDurationTimer();

//       await engine?.leaveChannel();

//       // Notify backend about call end
//       if (channelName != null) {
//         await _apiService.endCall(channelName!, callDuration.value);
//       }

//       isJoined.value = false;
//       remoteUid.value = 0;
//       isCallConnected.value = false;
//       callDuration.value = 0;

//       Get.back();
//     } catch (e) {
//       print('Error leaving call: $e');
//     }
//   }

//   Future<void> toggleMute() async {
//     try {
//       isMuted.value = !isMuted.value;
//       await engine?.muteLocalAudioStream(isMuted.value);
//     } catch (e) {
//       print('Error toggling mute: $e');
//     }
//   }

//   Future<void> toggleVideo() async {
//     try {
//       isVideoEnabled.value = !isVideoEnabled.value;
//       await engine?.muteLocalVideoStream(!isVideoEnabled.value);
//     } catch (e) {
//       print('Error toggling video: $e');
//     }
//   }

//   Future<void> switchCamera() async {
//     try {
//       await engine?.switchCamera();
//     } catch (e) {
//       print('Error switching camera: $e');
//     }
//   }

//   Future<void> toggleSpeaker() async {
//     try {
//       isSpeakerEnabled.value = !isSpeakerEnabled.value;
//       await engine?.setEnableSpeakerphone(isSpeakerEnabled.value);
//     } catch (e) {
//       print('Error toggling speaker: $e');
//     }
//   }

//   void _startCallDurationTimer() {
//     _callDurationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       callDuration.value++;
//     });
//   }

//   void _stopCallDurationTimer() {
//     _callDurationTimer?.cancel();
//     _callDurationTimer = null;
//   }

//   String getFormattedDuration() {
//     int hours = callDuration.value ~/ 3600;
//     int minutes = (callDuration.value % 3600) ~/ 60;
//     int seconds = callDuration.value % 60;

//     if (hours > 0) {
//       return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//     }
//     return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//   }

//   Future<void> _dispose() async {
//     _stopCallDurationTimer();
//     await engine?.leaveChannel();
//     await engine?.release();
//     engine = null;
//   }
// }

import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/constants/api_constants.dart';

class VideoCallController extends GetxController {
  RtcEngine? engine;

  final RxBool isJoined = false.obs;
  final RxInt remoteUid = 0.obs;
  final RxBool isMuted = false.obs;
  final RxBool isVideoEnabled = true.obs;
  final RxBool isSpeakerEnabled = true.obs;
  final RxBool isCallConnected = false.obs;
  final RxBool engineInitialized = false.obs;
  final RxBool isJoining = false.obs; // NEW: Track join process

  String? channelName;
  int? localUid;

  Timer? _callDurationTimer;
  final RxInt callDuration = 0.obs;

  // Observable getters
  RxBool get isVideoOff => RxBool(!isVideoEnabled.value);
  RxBool get isSpeakerOn => isSpeakerEnabled;

  @override
  void onClose() {
    _dispose();
    super.onClose();
  }

  /// Initialize Agora engine and permissions
  Future<void> initializeAgora() async {
    try {
      print('🎥 === INITIALIZING AGORA ===');

      // Step 1: Check permissions
      print('📷 Checking permissions...');
      var cameraStatus = await Permission.camera.status;
      var micStatus = await Permission.microphone.status;

      print('Camera: $cameraStatus, Mic: $micStatus');

      if (!cameraStatus.isGranted || !micStatus.isGranted) {
        print('⚠️ Requesting permissions...');
        var statuses = await [
          Permission.camera,
          Permission.microphone,
        ].request();

        if (statuses[Permission.camera] != PermissionStatus.granted ||
            statuses[Permission.microphone] != PermissionStatus.granted) {
          print('❌ Permissions DENIED!');
          Get.snackbar(
            'Permissions Required',
            'Camera and microphone permissions are required',
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }
      }
      print('✅ Permissions granted');

      // Step 2: Validate App ID
      if (ApiConstants.agoraAppId.isEmpty ||
          ApiConstants.agoraAppId == 'YOUR_AGORA_APP_ID') {
        print('❌ Invalid App ID!');
        Get.snackbar(
          'Configuration Error',
          'Agora App ID not configured',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      print('🔑 App ID: ${ApiConstants.agoraAppId}');

      // Step 3: Create engine
      print('🔧 Creating RTC Engine...');
      engine = createAgoraRtcEngine();

      await engine!.initialize(
        RtcEngineContext(
          appId: ApiConstants.agoraAppId,
          channelProfile: ChannelProfileType.channelProfileCommunication,
        ),
      );
      print('✅ Engine created');

      // Step 4: Register event handlers
      print('📡 Registering event handlers...');
      engine!.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            print('✅✅✅ JOIN SUCCESS! ✅✅✅');
            print('Local UID: ${connection.localUid}');
            print('Channel: ${connection.channelId}');
            print('Elapsed: ${elapsed}ms');

            localUid = connection.localUid;
            isJoined.value = true;
            isJoining.value = false;
            _startCallDurationTimer();

            Get.snackbar(
              'Connected',
              'Successfully joined channel',
              snackPosition: SnackPosition.TOP,
              duration: const Duration(seconds: 2),
            );
          },

          onUserJoined: (RtcConnection connection, int uid, int elapsed) {
            print('✅✅✅ REMOTE USER JOINED! ✅✅✅');
            print('Remote UID: $uid');
            print('Channel: ${connection.channelId}');

            remoteUid.value = uid;
            isCallConnected.value = true;

            Get.snackbar(
              'User Joined',
              'Another user has joined the call',
              snackPosition: SnackPosition.TOP,
              duration: const Duration(seconds: 2),
            );
          },

          onUserOffline:
              (
                RtcConnection connection,
                int uid,
                UserOfflineReasonType reason,
              ) {
                print('❌ Remote user left: $uid (Reason: $reason)');
                remoteUid.value = 0;
                isCallConnected.value = false;
              },

          onLeaveChannel: (RtcConnection connection, RtcStats stats) {
            print('👋 Left channel');
            print('Duration: ${stats.duration} seconds');
            isJoined.value = false;
            remoteUid.value = 0;
            isCallConnected.value = false;
          },

          onError: (ErrorCodeType err, String msg) {
            print('❌❌❌ AGORA ERROR! ❌❌❌');
            print('Error Code: $err');
            print('Message: $msg');

            isJoining.value = false;

            Get.snackbar(
              'Connection Error',
              'Error: $msg',
              snackPosition: SnackPosition.BOTTOM,
            );
          },

          onConnectionStateChanged:
              (
                RtcConnection connection,
                ConnectionStateType state,
                ConnectionChangedReasonType reason,
              ) {
                print('🔄 Connection State: $state (Reason: $reason)');
              },

          onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
            print('⚠️ Token will expire!');
          },

          onRequestToken: (RtcConnection connection) {
            print('⚠️ Token required! Check Agora Console settings.');
          },
        ),
      );
      print('✅ Event handlers registered');

      // Step 5: Enable video
      print('📹 Enabling video...');
      await engine!.enableVideo();
      await engine!.enableAudio(); // NEW: Explicitly enable audio
      await engine!.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
      await engine!.startPreview();
      print('✅ Video preview started');

      engineInitialized.value = true;
      print('✅✅✅ AGORA FULLY INITIALIZED! ✅✅✅');
    } catch (e, stack) {
      print('❌❌❌ INITIALIZATION FAILED! ❌❌❌');
      print('Error: $e');
      print('Stack: $stack');

      engineInitialized.value = false;
      Get.snackbar(
        'Initialization Error',
        'Failed to initialize: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Join channel with comprehensive error handling
  Future<void> joinCall(String channel) async {
    try {
      print('\n🚀 === JOINING CALL ===');
      print('Channel: $channel');

      if (channel.isEmpty) {
        print('❌ Empty channel name!');
        Get.snackbar('Error', 'Channel name is empty');
        return;
      }

      channelName = channel;
      isJoining.value = true;

      // Initialize if needed
      if (engine == null || !engineInitialized.value) {
        print('⚠️ Engine not initialized, initializing now...');
        await initializeAgora();

        if (engine == null) {
          print('❌ Failed to initialize engine!');
          isJoining.value = false;
          return;
        }

        // Wait for initialization to complete
        await Future.delayed(const Duration(milliseconds: 500));
      }

      print('📞 Calling joinChannel...');
      print('Token: [EMPTY STRING - Test Mode]');
      print('Channel: $channel');
      print('UID: 0 (auto-assign)');

      // Join channel
      await engine!.joinChannel(
        token:
            '007eJxTYLg/YZp5Zph+27Pud5MeqaVz/TpoobuwU+1zSE8OY+OVKZwKDCYpSaYm5qZGZmnGRibmaSYWySbmlqYWSeYGZqkGSZZJbgcEMxsCGRl0/5UwMEIhiM/BUJJaXKJraGTMwAAAvUQfkw==', // Empty string for test mode
        channelId: channel,
        uid: 0,
        options: const ChannelMediaOptions(
          channelProfile: ChannelProfileType.channelProfileCommunication,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
          publishCameraTrack: true, // NEW: Explicitly publish video
          publishMicrophoneTrack: true, // NEW: Explicitly publish audio
          autoSubscribeAudio: true, // NEW: Auto subscribe to audio
          autoSubscribeVideo: true, // NEW: Auto subscribe to video
        ),
      );

      print('✅ joinChannel() called successfully');
      print('⏳ Waiting for onJoinChannelSuccess callback...');

      // Wait up to 10 seconds for join to complete
      int waitCount = 0;
      while (!isJoined.value && waitCount < 100) {
        await Future.delayed(const Duration(milliseconds: 100));
        waitCount++;
      }

      if (isJoined.value) {
        print('✅✅✅ SUCCESSFULLY JOINED! ✅✅✅');
      } else {
        print('⚠️⚠️⚠️ Join timeout - still waiting for callback');
        print('Check Agora Console: Is Primary Certificate disabled?');
      }
    } catch (e, stack) {
      print('❌❌❌ JOIN CALL FAILED! ❌❌❌');
      print('Error: $e');
      print('Stack: $stack');

      isJoining.value = false;

      Get.snackbar(
        'Connection Failed',
        'Failed to join: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> leaveCall() async {
    print('👋 Leaving call...');
    _stopCallDurationTimer();
    await engine?.leaveChannel();
    isJoined.value = false;
    isJoining.value = false;
    remoteUid.value = 0;
    isCallConnected.value = false;
    callDuration.value = 0;
    print('✅ Left call');
  }

  Future<void> toggleMute() async {
    isMuted.value = !isMuted.value;
    await engine?.muteLocalAudioStream(isMuted.value);
    print('🔇 Mute: ${isMuted.value}');
  }

  Future<void> toggleVideo() async {
    isVideoEnabled.value = !isVideoEnabled.value;
    await engine?.muteLocalVideoStream(!isVideoEnabled.value);
    print('📹 Video: ${isVideoEnabled.value}');
  }

  Future<void> switchCamera() async {
    await engine?.switchCamera();
    print('🔄 Camera switched');
  }

  Future<void> toggleSpeaker() async {
    isSpeakerEnabled.value = !isSpeakerEnabled.value;
    await engine?.setEnableSpeakerphone(isSpeakerEnabled.value);
    print('🔊 Speaker: ${isSpeakerEnabled.value}');
  }

  void _startCallDurationTimer() {
    _callDurationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      callDuration.value++;
    });
  }

  void _stopCallDurationTimer() {
    _callDurationTimer?.cancel();
    _callDurationTimer = null;
  }

  String getFormattedDuration() {
    int hours = callDuration.value ~/ 3600;
    int minutes = (callDuration.value % 3600) ~/ 60;
    int seconds = callDuration.value % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> _dispose() async {
    print('🧹 Disposing controller...');
    _stopCallDurationTimer();
    await engine?.leaveChannel();
    await engine?.release();
    engine = null;
    engineInitialized.value = false;
    print('✅ Disposed');
  }
}
