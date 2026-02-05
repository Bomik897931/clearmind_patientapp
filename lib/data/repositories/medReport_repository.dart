import 'dart:io';

import 'package:Clarminds/data/repositories/user_repository.dart';

import '../../core/constants/api_constants.dart';
import '../models/api_response.dart';
import '../models/medicalReportModel.dart';
import '../services/api_service.dart';


class MedicalReportRepository {
  final ApiService _apiService = ApiService();

  /// GET reports
  Future<List<MedicalReport>> getReports({
    required int? userId, required String token,
  }) async {
    try {
      final response = await _apiService.get(
        endpoint: '${ApiConstants.getReportEndpoint}?userId=$userId',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final apiResponse = ApiResponse.fromJson(response);

      if (apiResponse.success && apiResponse.data != null) {
        final List list = apiResponse.data as List;
        return list
            .map((e) => MedicalReport.fromJson(e))
            .toList();
      } else {
        throw RepositoryException(
          apiResponse.message ?? 'Failed to load reports',
        );
      }
    } catch (e) {
      throw RepositoryException(e.toString());
    }
  }

  Future<bool> uploadReport({
    required String token,
    required File file,
    required String fileName,
  }) async {
    try{
      final response = await _apiService.multipartPost(
        endpoint: ApiConstants.uploadReportEndpoint,
        token: token,
        file: file,
        fileFieldName: 'File',
        fields: {
          'FileName': fileName,
        },
      );

      return response['success'] == true;
    }catch (e) {
      throw RepositoryException(e.toString());
    }

  }

  /// DELETE report
  Future<bool> deleteReport({
    required int documentId,required String token,
  }) async {
    try {
      final response = await _apiService.delete(
        endpoint:
        '${ApiConstants.deleteReportEndpoint}?documentId=$documentId',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final apiResponse = ApiResponse.fromJson(response['success']);
      return apiResponse.success;
    } catch (e) {
      throw RepositoryException(e.toString());
    }
  }
}
