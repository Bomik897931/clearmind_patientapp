// lib/repositories/slots_repository.dart
import 'package:patient_app/core/constants/api_constants.dart';
import 'package:patient_app/data/repositories/user_repository.dart';

import '../models/api_response.dart';
import '../models/appointment_model.dart';
import '../models/appointment_request_model.dart';
import '../models/slot_model.dart';
import '../services/api_service.dart';

class SlotsRepository {
  final ApiService _apiService;

  SlotsRepository({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<PaginatedResponse<Slot>> getSlots({
    required String token,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      print('🔵 Repository: Fetching slots (page: $pageNumber, size: $pageSize)');

      final response = await _apiService.get(
        endpoint: '${ApiConstants.getSlotsEndpoint}?pageNumber=$pageNumber&pageSize=$pageSize',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Slots response received');

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(response);

      if (apiResponse.success && apiResponse.data != null) {
        return PaginatedResponse.fromJson(
          apiResponse.data!,
              (json) => Slot.fromJson(json),
        );
      } else {
        throw RepositoryException(apiResponse.message ?? 'Failed to fetch slots');
      }
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to fetch slots: ${e.toString()}');
    }
  }

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

      if (apiResponse.success && apiResponse.data != null) {
        return Appointment.fromJson(apiResponse.data!);
      } else {
        throw RepositoryException(apiResponse.message ?? 'Failed to book appointment');
      }
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to book appointment: ${e.toString()}');
    }
  }
}