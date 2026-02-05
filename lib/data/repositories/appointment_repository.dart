// lib/repositories/appointments_repository.dart

import 'package:Clarminds/data/repositories/user_repository.dart';

import '../../core/constants/api_constants.dart';
import '../models/api_response.dart';
import '../models/appointment_model.dart';
import '../models/appointment_request_model.dart';
import '../models/slot_model.dart';
import '../services/api_service.dart';

class AppointmentsRepository {
  final ApiService _apiService;

  AppointmentsRepository({ApiService? apiService})
    : _apiService = apiService ?? ApiService();

  Future<PaginatedResponse<Appointment>> getAppointments({
    required String token,
    int pageNumber = 1,
    int pageSize = 10,
    String? search,
  }) async {
    try {
      // Build URL with query parameters
      String endpoint =
          '${ApiConstants.getAppointmentsEndpoint}?PageNumber=$pageNumber&PageSize=$pageSize';

      if (search != null && search.isNotEmpty) {
        endpoint += '&Search=$search';
      }

      print('🔵 Repository: Fetching appointments - $endpoint');

      final response = await _apiService.get(
        endpoint: endpoint,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Appointments response received');

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(response);

      if (apiResponse.success && apiResponse.data != null) {
        return PaginatedResponse.fromJson(
          apiResponse.data!,
          (json) => Appointment.fromJson(json),
        );
      } else {
        throw RepositoryException(
          apiResponse.message ?? 'Failed to fetch appointments',
        );
      }
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException(
        'Failed to fetch appointments: ${e.toString()}',
      );
    }
  }

  Future<List<Slot>> getDoctorSlots({
    required String token,
    required int doctorId,
    required String date,
    required int slotDuration,
  }) async {
    try {
      String endpoint =
          '${ApiConstants.doctorSlotsEndpoint}?doctorId=$doctorId&date=$date&slotDuration=$slotDuration';

      print('🔵 Repository: Fetching slots - $endpoint');

      final response = await _apiService.get(
        endpoint: endpoint,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Response received');
      print('📦 Raw response: $response');

      // Direct parsing
      if (response['success'] == true) {
        final List<dynamic> slotsData = response['data'] as List<dynamic>;

        print('📊 Parsing ${slotsData.length} slots...');

        final slots = slotsData
            .map((json) => Slot.fromJson(json as Map<String, dynamic>))
            .toList();

        print('✅ Repository: Successfully parsed ${slots.length} slots');
        return slots;
      } else {
        final message = response['message'] ?? 'Failed to fetch slots';
        print('❌ Repository: API returned error - $message');
        throw RepositoryException(message);
      }
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e, stackTrace) {
      print('🔴 Repository: Unexpected error - $e');
      print('📍 StackTrace: $stackTrace');
      throw RepositoryException('Failed to fetch slots: ${e.toString()}');
    }
  }

  /* Future<List<Slot>> getDoctorSlots({
    required String token,
    required int doctorId,
    required String date,
    required int slotDuration,
  }) async {
    try {
      // Build URL with query parameters
      String endpoint =
          '${ApiConstants.doctorSlotsEndpoint}?doctorId=$doctorId&date=$date&slotDuration=$slotDuration';

      print('🔵 Repository: Fetching slots - $endpoint');

      final response = await _apiService.get(
        endpoint: endpoint,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Slots response received');

      final apiResponse = ApiResponse.fromJson(response);

      if (apiResponse.success && apiResponse.data != null) {
        final List<dynamic> slotsData = apiResponse.data as List<dynamic>;
        return slotsData
            .map((json) => Slot.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw RepositoryException(
          apiResponse.message ?? 'Failed to fetch slots',
        );
      }
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to fetch slots: ${e.toString()}');
    }
  }*/

  Future<Appointment> bookAppointment({
    required String token,
    required BookAppointmentRequest request,
  }) async {
    try {
      print('🔵 Repository: Booking appointment - ${request.toJson()}');

      final response = await _apiService.post(
        endpoint: ApiConstants.bookAppointmentEndpoint,
        body: request.toJson(),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Appointment booked successfully');

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(response);
      print('🟢 Repository: Appointment booked successfully $apiResponse');
      if (apiResponse.success && apiResponse.data != null) {
        return Appointment.fromJson(apiResponse.data!);
      } else {
        throw RepositoryException(
          apiResponse.message ?? 'Failed to book appointment',
        );
      }
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to book appointment: ${e.toString()}');
    }
  }

  Future<bool> cancelAppointment({
    required String token,
    required int appointmentId,
  }) async {
    try {
      print('🔵 Repository: Cancelling appointment $appointmentId');

      final response = await _apiService.delete(
        endpoint: '${ApiConstants.cancelAppointmentEndpoint}/$appointmentId',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Appointment cancelled successfully');

      final apiResponse = ApiResponse.fromJson(response);
      return apiResponse.success;
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException(
        'Failed to cancel appointment: ${e.toString()}',
      );
    }
  }
  Future<Map<String, dynamic>> getPatientProfile({
    required String token,
  }) async {
    try {
      print('🔵 Repository: Fetching patient profile');

      final response = await _apiService.get(
        endpoint: ApiConstants.getUserEndpoint,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Patient profile response received');
      print('📦 Raw response: $response');

      // ✅ This API does NOT return ApiResponse wrapper
      if (response is Map<String, dynamic>) {
        return response;
      } else {
        throw RepositoryException('Invalid patient profile response');
      }

    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException(
        'Failed to fetch patient profile: ${e.toString()}',
      );
    }
  }

  Future<Map<String, dynamic>> getIdentityDocumentTypes({
    required String token,
  }) async {
    try {
      print('🔵 Repository: Fetching identity document types');

      final response = await _apiService.get(
        endpoint: ApiConstants.getIdentityDocsTypeEndpoint,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Identity document types response received');
      print('📦 Raw response: $response');

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(response);
      print('📦 Raw response: $apiResponse');

      if (apiResponse.success && apiResponse.data != null) {
        return {
          'data': apiResponse.data,
        };
      } else {
        throw RepositoryException(
          apiResponse.message ?? 'Failed to fetch identity document types',
        );
      }
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException(
        'Failed to fetch identity document types: ${e.toString()}',
      );
    }
  }

}
