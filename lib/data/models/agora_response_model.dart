// lib/models/agora_token_response.dart
class AgoraTokenResponse {
  final String appId;
  final String channelName;
  final String token;
  final int uid;

  AgoraTokenResponse({
    required this.appId,
    required this.channelName,
    required this.token,
    required this.uid,
  });

  factory AgoraTokenResponse.fromJson(Map<String, dynamic> json) {
    return AgoraTokenResponse(
      appId: json['appId'],
      channelName: json['channelName'],
      token: json['token'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appId': appId,
      'channelName': channelName,
      'token': token,
      'uid': uid,
    };
  }
}