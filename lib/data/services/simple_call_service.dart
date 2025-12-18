import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class SimpleCallService extends GetxController {
  static final SimpleCallService _instance = SimpleCallService._();
  factory SimpleCallService() => _instance;
  SimpleCallService._();

  final RxBool isRinging = false.obs;
  final RxString incomingCallFrom = ''.obs;
  final RxString incomingChannelName = ''.obs;

  // Start ringtone
  void startRingtone() {
    isRinging.value = true;
    FlutterRingtonePlayer().playRingtone(
      looping: true,
      volume: 1.0,
      asAlarm: false,
    );
    _startVibration();
  }

  // Stop ringtone
  void stopRingtone() {
    isRinging.value = false;
    FlutterRingtonePlayer().stop();
    _stopVibration();
  }

  // Start vibration
  Future<void> _startVibration() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(pattern: [500, 1000, 500, 1000], repeat: 0);
    }
  }

  // Stop vibration
  void _stopVibration() {
    Vibration.cancel();
  }

  // Show incoming call screen
  void showIncomingCall({
    required String callerName,
    required String channelName,
  }) {
    incomingCallFrom.value = callerName;
    incomingChannelName.value = channelName;
    startRingtone();

    Get.toNamed(
      '/incoming-call',
      arguments: {'callerName': callerName, 'channelName': channelName},
    );
  }

  // Accept call
  void acceptCall() {
    stopRingtone();
    Get.offNamed(
      '/video-call',
      arguments: {'channelName': incomingChannelName.value},
    );
  }

  // Reject call
  void rejectCall() {
    stopRingtone();
    incomingCallFrom.value = '';
    incomingChannelName.value = '';
    Get.back();
  }

  @override
  void onClose() {
    stopRingtone();
    super.onClose();
  }
}
