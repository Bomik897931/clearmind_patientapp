import 'package:patient_app/core/constants/api_constants.dart';
import 'package:patient_app/data/repositories/user_repository.dart';

import '../models/api_response.dart';
import '../models/review_model.dart';
import '../services/api_service.dart';

class ReviewRepository {
  final ApiService _apiService;

  ReviewRepository({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<String> addReview({
    required String token,
    required int doctorId,
    required int appointmentId,
    required double rating,
    required String reviewText,
  }) async {
    try {
      print('🔵 Repository: Adding review for doctor $doctorId');

      final response = await _apiService.post(
        endpoint: ApiConstants.addReviewEndpoint,
        body: {
          'doctorId': 15,
          'appointmentId': appointmentId,
          'rating': rating,
          'reviewText': reviewText,
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Review added successfully');

      final apiResponse = ApiResponse.fromJson(response);
      if (apiResponse.success) {
        return apiResponse.data ?? 'Review added successfully';
      } else {
        throw RepositoryException(apiResponse.message ?? 'Failed to add review');
      }
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to add review: ${e.toString()}');
    }
  }

  Future<List<ReviewModel>> getReviews({
    required String token,
    required int doctorId,
  }) async {
    try {
      print('🔵 Repository: Fetching reviews for doctor $doctorId');

      final response = await _apiService.get(
        endpoint: '${ApiConstants.getReviewsEndpoint}?doctorId=$doctorId',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Reviews fetched successfully');

      final apiResponse = ApiResponse.fromJson(response);
      if (apiResponse.success && apiResponse.data != null) {
        final List<dynamic> reviewsData = apiResponse.data as List<dynamic>;
        return reviewsData
            .map((json) => ReviewModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw RepositoryException(
          apiResponse.message ?? 'Failed to fetch reviews',
        );
      }
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to fetch reviews: ${e.toString()}');
    }
  }
}