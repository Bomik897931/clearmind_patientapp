// lib/repositories/appointments_repository.dart
import 'package:patient_app/core/constants/api_constants.dart';
import 'package:patient_app/data/repositories/user_repository.dart';

import '../models/api_response.dart';
import '../models/appointment_model.dart';
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
      String endpoint = '${ApiConstants.getAppointmentsEndpoint}?PageNumber=$pageNumber&PageSize=$pageSize';

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
        throw RepositoryException(apiResponse.message ?? 'Failed to fetch appointments');
      }
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to fetch appointments: ${e.toString()}');
    }
  }

  Future<List<Slot>> getDoctorSlots({
    required String token,
    required int doctorId,
    required String date,
  }) async {
    try {
      // Build URL with query parameters
      String endpoint = '${ApiConstants.doctorSlotsEndpoint}?doctorId=$doctorId&date=$date';

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
      }else {
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
  }

}