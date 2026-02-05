import '../../core/constants/api_constants.dart';
import '../models/api_response.dart';
import '../models/profile_model.dart';
import '../models/refresh_token_model.dart';
import '../models/register_request.dart';
import '../models/register_response.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository({ApiService? apiService})
    : _apiService = apiService ?? ApiService();

  Future<void> registerDevice({
    required String token,
    required String deviceToken,
    required String platform,
  }) async {
    try {
      print('🔵 Repository: Registering device - Platform: $platform');

      final response = await _apiService.post(
        endpoint: ApiConstants.registerDeviceEndpoint,
        body: {'deviceToken': deviceToken, 'platform': platform},
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Device registered successfully');

      final apiResponse = ApiResponse<String>.fromJson(response);

      if (!apiResponse.success) {
        throw RepositoryException(
          apiResponse.message ?? 'Failed to register device',
        );
      }
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to register device: ${e.toString()}');
    }
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      final response = await _apiService.post(
        endpoint: ApiConstants.registerEndpoint,
        body: request.toJson(),
      );
      print("response... $response");

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(response);
      print("apiresponse..  $apiResponse");

      if (apiResponse.success && apiResponse.data != null) {
        return RegisterResponse.fromJson(apiResponse.data!);
      } else {
        throw RepositoryException(apiResponse.message ?? 'Registration failed');
      }
    } on ApiException catch (e) {
      throw RepositoryException(_parseErrorMessage(e.message));
    } catch (e) {
      throw RepositoryException('An unexpected error occurred');
    }
  }

  Future<User> login(String email, String password, {String role = ''}) async {
    try {
      print('🔵 Repository: Starting login request...');

      final response = await _apiService.post(
        endpoint: ApiConstants.loginEndpoint,
        body: {
          'username': email, // API expects 'username' not 'email'
          'password': password,
          'role': role,
        },
      );

      print('🟢 Repository: Login response received: $response');

      // Login API returns user data directly (not wrapped in ApiResponse)
      if (response.containsKey('token') && response.containsKey('userId')) {
        print('✅ Repository: Token found, creating User object');
        return User.fromJson(response);
      } else if (response.containsKey('message')) {
        print(
          '❌ Repository: Login failed with message: ${response['message']}',
        );
        throw RepositoryException(response['message']);
      } else {
        print('❌ Repository: Unexpected response format');
        throw RepositoryException('Invalid response format');
      }
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(_parseErrorMessage(e.message));
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException(
        'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  Future<RefreshTokenModel?> refreshToken(String token) async {
    try {
      final response = await _apiService.post(
        endpoint: ApiConstants.refreshToken,
        body: {"token": token},
      );

      final apiResponse = RefreshTokenModel.fromJson(response);
      print(response);

      if (apiResponse.isValid != null) {
        print("success");
        return RefreshTokenModel.fromJson(response);
      } else {
        throw RepositoryException(apiResponse.message ?? 'Token has expired');
      }
    } catch (e) {
      throw RepositoryException(
        'An unexpected error from refreshTokenRepo : ${e.toString()}',
      );
    }
  }

  Future<bool> updateMyProfile(
    int patientId,
    Map<String, dynamic> profileData,
    String token,
  ) async {
    try {
      print('🔵 Repository: Starting update profile request...');

      final response = await _apiService.put(
        // endpoint: "/api/Patient/update-myprofile?patientId=$patientId",
        endpoint: "${ApiConstants.updateProfileEndpoint}?patientId=$patientId",
        body: profileData,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Update profile response: $response');

      if (response['success'] == true) {
        print('✅ Repository: Profile updated successfully.');
        return true; // SUCCESS
      } else {
        final message = response['message'] ?? "Failed to update profile";
        print('❌ Repository: API Error - $message');
        throw RepositoryException(message);
      }
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(_parseErrorMessage(e.message));
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException(
        "An unexpected error occurred: ${e.toString()}",
      );
    }
  }

  // Future<User> login(String email, String password) async {
  //   try {
  //     final response = await _apiService.post(
  //       endpoint: ApiConstants.loginEndpoint,
  //       body: {
  //         'username': email,
  //         'password': password,
  //         'role':''
  //       },
  //     );
  //
  //     final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(response);
  //     print("loginapiresponse..  $apiResponse");
  //
  //     if (apiResponse.success && apiResponse.data != null) {
  //       return User.fromJson(apiResponse.data!);
  //     } else {
  //       throw RepositoryException(
  //         apiResponse.message ?? 'Login failed',
  //       );
  //     }
  //   } on ApiException catch (e) {
  //     throw RepositoryException(_parseErrorMessage(e.message));
  //   } catch (e) {
  //     throw RepositoryException('An unexpected error occurred');
  //   }
  // }

  Future<UserProfile> getProfile(String token) async {
    try {
      print('🔵 Repository: Fetching profile with token');

      final response = await _apiService.get(
        endpoint: ApiConstants.getProfileEndpoint,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Profile response: $response');

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(response);

      if (apiResponse.success && apiResponse.data != null) {
        return UserProfile.fromJson(apiResponse.data!);
      } else {
        throw RepositoryException(
          apiResponse.message ?? 'Failed to fetch profile',
        );
      }
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(_parseErrorMessage(e.message));
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to fetch profile: ${e.toString()}');
    }
  }

  String _parseErrorMessage(String message) {
    // Handle duplicate email error
    if (message.contains('duplicate key') && message.contains('Email')) {
      return 'This email is already registered. Please use a different email or try logging in.';
    }

    // Handle database errors
    if (message.contains('entity changes')) {
      return 'Unable to complete registration. Please try again.';
    }

    // Handle network errors
    if (message.contains('Network error')) {
      return 'Network connection failed. Please check your internet connection.';
    }

    return message;
  }
}

class RepositoryException implements Exception {
  final String message;

  RepositoryException(this.message);

  @override
  String toString() => message;
}
