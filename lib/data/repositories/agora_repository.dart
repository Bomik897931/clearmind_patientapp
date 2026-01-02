// lib/repositories/agora_repository.dart
import 'package:patient_app/core/constants/api_constants.dart';
import 'package:patient_app/data/repositories/user_repository.dart';

import '../models/agora_response_model.dart';
import '../services/api_service.dart';

class AgoraRepository {
  final ApiService _apiService;

  AgoraRepository({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<AgoraTokenResponse> getAgoraToken({
    required String token,
    required int appointmentId,
  }) async {
    try {
      print('🔵 Repository: Fetching Agora token for appointment: $appointmentId');

      final response = await _apiService.get(
        endpoint: '${ApiConstants.getAgoraTokenEndpoint}/$appointmentId',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Agora token received');

      return AgoraTokenResponse.fromJson(response);
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to get Agora token: ${e.toString()}');
    }
  }
}