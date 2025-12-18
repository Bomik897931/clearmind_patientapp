// lib/repositories/doctors_repository.dart
import 'package:patient_app/core/constants/api_constants.dart';
import 'package:patient_app/data/repositories/user_repository.dart';

import '../models/api_response.dart';
import '../models/category_model.dart';
import '../models/doctor_model.dart';
import '../models/slot_model.dart';
import '../services/api_service.dart';

class DoctorsRepository {
  final ApiService _apiService;

  DoctorsRepository({ApiService? apiService})
      : _apiService = apiService ?? ApiService();


  Future<PaginatedResponse<DoctorModel>> getDoctors({
    required String token,
    String specialization = 'all',
    int pageNumber = 1,
    int pageSize = 10,
    String? search, // Add search parameter
  }) async {
    try {

      String finalSpec = (specialization.isEmpty || specialization == 'all')
          ? 'all'
          : specialization.toLowerCase();
      String endpoint = '${ApiConstants
          .getDoctorsEndpoint}?Specialization=$finalSpec&PageNumber=$pageNumber&PageSize=$pageSize';

      // Add search query if provided
      if (search != null && search.isNotEmpty) {
        endpoint += '&Search=$search';
      }

      print('🔵 Repository: Fetching doctors - $endpoint');

      final response = await _apiService.get(
        endpoint: endpoint,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Doctors response received');

      final outerResponse = ApiResponse<Map<String, dynamic>>.fromJson(
          response);

      if (outerResponse.success && outerResponse.data != null) {
        final innerData = outerResponse.data!['data'] as Map<String, dynamic>;

        return PaginatedResponse.fromJson(
          innerData,
              (json) => DoctorModel.fromJson(json),
        );
      } else {
        throw RepositoryException('Failed to fetch doctors');
      }
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to fetch doctors: ${e.toString()}');
    }
  }

  Future<List<Specialization>> getSpecializations({
    required String token,
  }) async {
    try {
      print('🔵 Repository: Fetching specializations');

      final response = await _apiService.getRaw(
        endpoint: ApiConstants.getSpecializationsEndpoint,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Response: $response');
      print('RuntimeType: ${response.runtimeType}');

      List<dynamic> specializationsList;

      if (response is List) {
        specializationsList = response;
      } else if (response is Map<String, dynamic>) {
        if (response['data'] is List) {
          specializationsList = response['data'];
        } else {
          throw RepositoryException(
              'Expected "data" key containing List<dynamic>');
        }
      } else {
        throw RepositoryException('Invalid response format');
      }

      return specializationsList
          .map((item) => Specialization.fromJson(item))
          .toList();

    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to fetch specializations: ${e.toString()}');
    }
  }




  // Future<PaginatedResponse<DoctorModel>> getDoctors({
  //   required String token,
  //   String specialization = 'all',
  //   int pageNumber = 1,
  //   int pageSize = 10,
  // }) async {
  //   try {
  //     final endpoint = '${ApiConstants.getDoctorsEndpoint}?Specialization=$specialization&PageNumber=$pageNumber&PageSize=$pageSize';
  //
  //     print('🔵 Repository: Fetching doctors - $endpoint');
  //
  //     final response = await _apiService.get(
  //       endpoint: endpoint,
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //     );
  //
  //     print('🟢 Repository: Doctors response received');
  //
  //     // Parse nested response structure
  //     final outerResponse = ApiResponse<Map<String, dynamic>>.fromJson(response);
  //
  //     if (outerResponse.success && outerResponse.data != null) {
  //       final innerData = outerResponse.data!['data'] as Map<String, dynamic>;
  //
  //       return PaginatedResponse.fromJson(
  //         innerData,
  //             (json) => DoctorModel.fromJson(json),
  //       );
  //     } else {
  //       throw RepositoryException('Failed to fetch doctors');
  //     }
  //   } on ApiException catch (e) {
  //     print('🔴 Repository: ApiException - ${e.message}');
  //     throw RepositoryException(e.message);
  //   } catch (e) {
  //     print('🔴 Repository: Unexpected error - $e');
  //     throw RepositoryException('Failed to fetch doctors: ${e.toString()}');
  //   }
  // }
  Future<DoctorModel> getDoctorById({
    required String token,
    required int doctorId,
  }) async {
    try {
      final endpoint = '${ApiConstants.getDoctorByIdEndpoint}/$doctorId';

      print('🔵 Repository: Fetching doctor details - $endpoint');

      final response = await _apiService.get(
        endpoint: endpoint,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Doctor details response received');

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(response);

      if (apiResponse.success && apiResponse.data != null) {
        return DoctorModel.fromJson(apiResponse.data!);
      } else {
        throw RepositoryException('Failed to fetch doctor details');
      }
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to fetch doctor details: ${e.toString()}');
    }
  }

  Future<bool> addFavorite({
    required String token,
    required int doctorId,
  }) async {
    try {
      print('🔵 Repository: Adding favorite for doctor $doctorId');

      final response = await _apiService.post(
        endpoint: '${ApiConstants.addFavoriteEndpoint}?doctorId=$doctorId',
        body: {},
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Favorite added successfully');

      final apiResponse = ApiResponse.fromJson(response);
      return apiResponse.success;
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to add favorite: ${e.toString()}');
    }
  }

  Future<bool> removeFavorite({
    required String token,
    required int doctorId,
  }) async {
    try {
      print('🔵 Repository: Removing favorite for doctor $doctorId');

      final response = await _apiService.post(
        endpoint: '${ApiConstants.removeFavoriteEndpoint}?doctorId=$doctorId',
        body: {},
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Favorite removed successfully');

      final apiResponse = ApiResponse.fromJson(response);
      return apiResponse.success;
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to remove favorite: ${e.toString()}');
    }
  }}
