// lib/repositories/agora_repository.dart

import 'package:Clarminds/data/repositories/user_repository.dart';

import '../../core/constants/api_constants.dart';
import '../models/agora_response_model.dart';
import '../models/api_response.dart';
import '../services/api_service.dart';

class AgoraRepository {
  final ApiService _apiService;

  AgoraRepository({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

/*  Future<AgoraTokenResponse> getAgoraToken({
    required String token,
    required int appointmentId,
  }) async {
    try {
      print('🔵 Repository: Fetching Agora token for appointment: $appointmentId');

      final response = await _apiService.get(
        endpoint: '${ApiConstants.getAgoraTokenEndpoint}/$appointmentId?role=patient',
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
  }*/



// lib/repositories/agora_repository.dart
  Future<AgoraTokenResponse> getAgoraToken({
    required String token,
    required int appointmentId,
  }) async {
    try {
      print('🔵 Repository: Fetching Agora token for appointment: $appointmentId');

      final response = await _apiService.get(
        endpoint: '${ApiConstants.getAgoraTokenEndpoint}/$appointmentId?role=patient',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Agora token received');

      return AgoraTokenResponse.fromJson(response);
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');

      // Check for specific error messages
      if (e.message.contains('already connected') ||
          e.message.contains('another device')) {
        throw RepositoryException(
          'You are already connected on another device. Please disconnect and try again.',
        );
      }

      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to get Agora token: ${e.toString()}');
    }
  }

  /// LEAVE CALL API
  Future<void> leaveAgoraCall({
    required String token,
    required int appointmentId,
  }) async {

    try {
      print('🔵 Repository: Ending call for appointment: $appointmentId');

      final response = await _apiService.post(
        endpoint: '${ApiConstants.leaveAgoraCallEndpoint}?appointmentId=$appointmentId&role=patient',
        body: {}, // Empty body if not required
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: End call response: $response');

      final apiResponse = ApiResponse<dynamic>.fromJson(response);

      if (apiResponse.success) {
        print('✅ Call ended successfully');
      } else {
        print('⚠️ Call end failed: ${apiResponse.message}');
        // Don't throw error if appointment not found - call already ended
        if (apiResponse.message?.contains('Not Present') ?? false) {
          print('ℹ️ Appointment not found, but call will be ended locally');
        } else {
          throw RepositoryException(apiResponse.message ?? 'Failed to end call');
        }
      }
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      // Don't throw - allow local cleanup even if API fails
      print('⚠️ API call failed, but continuing with local cleanup');
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      // Don't throw - allow local cleanup even if API fails
      print('⚠️ Error ending call on server, but continuing with local cleanup');
    }
  }
  }
  //   try {
  //     print('🔵 Repository: Leaving Agora call for appointment: $appointmentId');
  //
  //     await _apiService.get(
  //       endpoint:
  //       '${ApiConstants.leaveAgoraCallEndpoint}?appointmentId=$appointmentId&role=patient',
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //     );
  //
  //     print('🟢 Repository: Leave call successful');
  //   } on ApiException catch (e) {
  //     print('🔴 Repository: ApiException - ${e.message}');
  //     throw RepositoryException(e.message);
  //   } catch (e) {
  //     print('🔴 Repository: Unexpected error - $e');
  //     throw RepositoryException('Failed to leave call');
  //   }
  // }
