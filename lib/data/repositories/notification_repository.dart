import 'package:patient_app/data/repositories/user_repository.dart';

import '../../core/constants/api_constants.dart';
import '../models/api_response.dart';
import '../models/notification_model.dart';
import '../services/api_service.dart';

class NotificationRepository {
  final ApiService _apiService;

  NotificationRepository({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<List<NotificationModel>> getNotifications({
    required String token,
  }) async {
    try {
      print('🔵 Repository: Fetching notifications');

      final response = await _apiService.get(
        endpoint: ApiConstants.notificationsEndpoint,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Notifications fetched successfully');

      final apiResponse = ApiResponse.fromJson(response);
      if (apiResponse.success && apiResponse.data != null) {
        final dataMap = apiResponse.data as Map<String, dynamic>;
        final List<dynamic> items = dataMap['items'] ?? [];

        return items
            .map((json) =>
            NotificationModel.fromJson(json as Map<String, dynamic>))
            .toList();
        // final List<dynamic> notificationsData = apiResponse.data as List<dynamic>;
        // return notificationsData
        //     .map((json) => NotificationModel.fromJson(json as Map<String, dynamic>))
        //     .toList();
      } else {
        throw RepositoryException(
          apiResponse.message ?? 'Failed to fetch notifications',
        );
      }
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to fetch notifications: ${e.toString()}');
    }
  }

  Future<bool> markAsRead({
    required String token,
    required int notificationId,
  }) async {
    try {
      print('🔵 Repository: Marking notification $notificationId as read');

      final response = await _apiService.post(
        endpoint: '${ApiConstants.markNotificationReadEndpoint}/$notificationId',
        body: {},
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Notification marked as read');

      final apiResponse = ApiResponse.fromJson(response);
      return apiResponse.success;
    } catch (e) {
      print('🔴 Repository: Error marking as read - $e');
      return false;
    }
  }
}
