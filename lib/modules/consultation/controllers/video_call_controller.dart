// import 'dart:async';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../../../core/constants/api_constants.dart';
// import '../../../data/services/api_service.dart';

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

//   // Compatibility getters for alternative naming
//   RxBool get isVideoOff => RxBool(!isVideoEnabled.value);
//   RxBool get isSpeakerOn => isSpeakerEnabled;

//   @override
//   void onClose() {
//     _dispose();
//     super.onClose();
//   }

//   Future<void> initializeAgora() async {
//     try {
//       // Request permissions
//       await [Permission.camera, Permission.microphone].request();

//       // Create Agora engine
//       engine = createAgoraRtcEngine();
//       await engine!.initialize(
//         RtcEngineContext(
//           appId: ApiConstants.agoraAppId,
//           channelProfile: ChannelProfileType.channelProfileCommunication,
//         ),
//       );

//       // Register event handlers
//       engine!.registerEventHandler(
//         RtcEngineEventHandler(
//           onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//             print('Local user ${connection.localUid} joined channel');
//             isJoined.value = true;
//             localUid = connection.localUid;
//             _startCallDurationTimer();
//           },
//           onUserJoined: (RtcConnection connection, int uid, int elapsed) {
//             print('Remote user $uid joined');
//             remoteUid.value = uid;
//             isCallConnected.value = true;
//           },
//           onUserOffline:
//               (
//                 RtcConnection connection,
//                 int uid,
//                 UserOfflineReasonType reason,
//               ) {
//                 print('Remote user $uid left channel');
//                 remoteUid.value = 0;
//                 isCallConnected.value = false;
//               },
//           onLeaveChannel: (RtcConnection connection, RtcStats stats) {
//             print('Left channel');
//             isJoined.value = false;
//             remoteUid.value = 0;
//             isCallConnected.value = false;
//           },
//           onError: (ErrorCodeType err, String msg) {
//             print('Agora Error: $err - $msg');
//           },
//         ),
//       );

//       // Enable video
//       await engine!.enableVideo();
//       await engine!.startPreview();

//       print('Agora initialized successfully');
//     } catch (e) {
//       print('Error initializing Agora: $e');
//       Get.snackbar(
//         'Error',
//         'Failed to initialize video: ${e.toString()}',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
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
//       Get.back();
//     }
//   }

//   // Alias for compatibility
//   Future<void> endCall() async {
//     await leaveCall();
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
