// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:get/get.dart' as getx;
// import 'package:patient_app/data/services/StorageService.dart';
// import 'package:patient_app/data/models/uservc_model.dart';
// import '../../core/constants/api_constants.dart';
// import '../models/user_model.dart';
//
// class ApiService {
//   static final ApiService _instance = ApiService._internal();
//   factory ApiService() => _instance;
//   ApiService._internal();
//
//   late Dio _dio;
//   final _storage = getx.Get.find<StorageService>();
//
//   void init() {
//     _dio = Dio(
//       BaseOptions(
//         baseUrl: ApiConstants.baseUrl,
//         connectTimeout: const Duration(seconds: 30),
//         receiveTimeout: const Duration(seconds: 30),
//         headers: ApiConstants.getHeaders(),
//       ),
//     );
//
//     // Add interceptor for token
//     _dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           final token = _storage.getToken();
//           if (token != null) {
//             options.headers['Authorization'] = 'Bearer $token';
//           }
//           return handler.next(options);
//         },
//         onError: (error, handler) async {
//           if (error.response?.statusCode == 401) {
//             // Token expired - handle refresh or logout
//             _storage.clearAuth();
//             getx.Get.offAllNamed('/login');
//           }
//           return handler.next(error);
//         },
//       ),
//     );
//   }
//
//   // Login
//   Future<UserVCModel> login(String email, String password) async {
//     try {
//       final response = await _dio.post(
//         ApiConstants.loginEndpoint,
//         data: {'email': email, 'password': password},
//       );
//
//       if (response.statusCode == 200) {
//         final userData = response.data['data'] ?? response.data;
//         final user = UserVCModel.fromJson(userData);
//
//         // Save token
//         if (user.token != null) {
//           await _storage.saveToken(user.token!);
//         }
//
//         return user;
//       }
//
//       throw Exception(response.data['message'] ?? 'Login failed');
//     } on DioException catch (e) {
//       throw _handleError(e);
//     }
//   }
//
//   // Register
//   Future<UserVCModel> register(
//     String name,
//     String email,
//     String password,
//   ) async {
//     try {
//       final response = await _dio.post(
//         ApiConstants.registerEndpoint,
//         data: {'name': name, 'email': email, 'password': password},
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final userData = response.data['data'] ?? response.data;
//         final user = UserVCModel.fromJson(userData);
//
//         // Save token
//         if (user.token != null) {
//           await _storage.saveToken(user.token!);
//         }
//
//         return user;
//       }
//
//       throw Exception(response.data['message'] ?? 'Registration failed');
//     } on DioException catch (e) {
//       throw _handleError(e);
//     }
//   }
//
//   // Get Profile
//   Future<UserVCModel> getProfile() async {
//     try {
//       final response = await _dio.get(ApiConstants.profile);
//
//       if (response.statusCode == 200) {
//         final userData = response.data['data'] ?? response.data;
//         return UserVCModel.fromJson(userData);
//       }
//
//       throw Exception('Failed to load profile');
//     } on DioException catch (e) {
//       throw _handleError(e);
//     }
//   }
//
//   // Get Agora Token
//   Future<Map<String, dynamic>> getAgoraToken(
//     String channelName,
//     int uid,
//   ) async {
//     try {
//       final response = await _dio.post(
//         ApiConstants.getAgoraToken,
//         data: {'channelName': channelName, 'uid': uid},
//       );
//
//       if (response.statusCode == 200) {
//         return {
//           'token': response.data['token'],
//           'channelName': channelName,
//           'uid': uid,
//         };
//       }
//
//       throw Exception('Failed to get Agora token');
//     } on DioException catch (e) {
//       throw _handleError(e);
//     }
//   }
//
//   // Start Call
//   Future<void> startCall(String channelName, String receiverId) async {
//     try {
//       await _dio.post(
//         ApiConstants.startCall,
//         data: {'channelName': channelName, 'receiverId': receiverId},
//       );
//     } on DioException catch (e) {
//       throw _handleError(e);
//     }
//   }
//
//   // End Call
//   Future<void> endCall(String channelName, int duration) async {
//     try {
//       await _dio.post(
//         ApiConstants.endCall,
//         data: {'channelName': channelName, 'duration': duration},
//       );
//     } on DioException catch (e) {
//       throw _handleError(e);
//     }
//   }
//
//   // Logout
//   Future<void> logout() async {
//     try {
//       await _dio.post(ApiConstants.logout);
//     } finally {
//       await _storage.clearAuth();
//     }
//   }
//
//   String _handleError(DioException e) {
//     if (e.response != null) {
//       return e.response?.data['message'] ?? 'An error occurred';
//     } else if (e.type == DioExceptionType.connectionTimeout) {
//       return 'Connection timeout';
//     } else if (e.type == DioExceptionType.receiveTimeout) {
//       return 'Receive timeout';
//     } else if (e.type == DioExceptionType.connectionError) {
//       return 'No internet connection';
//     }
//     return 'Something went wrong';
//   }
// }


import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/constants/api_constants.dart';

class ApiService {
  final String baseUrl;

  ApiService({String? baseUrl})
      : baseUrl = baseUrl ?? ApiConstants.baseUrl;

  Future<Map<String, dynamic>> post({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');

      print('🔵 API Service: POST $url');
      print('🔵 Request Body: $body');

      final defaultHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final response = await http.post(
        url,
        headers: headers ?? defaultHeaders,
        body: jsonEncode(body),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw ApiException('Connection timeout. Please check your internet connection.');
        },
      );

      print('🟢 API Service: Response Status: ${response.statusCode}');
      print('🟢 API Service: Response Body: ${response.body}');

      return _handleResponse(response);
    } on http.ClientException catch (e) {
      print('🔴 API Service: ClientException - $e');
      throw ApiException('Network connection failed. Please check your internet connection.');
    } on FormatException catch (e) {
      print('🔴 API Service: FormatException - $e');
      throw ApiException('Invalid response format from server.');
    } catch (e) {
      print('🔴 API Service: Unexpected error - $e');
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');

      final response = await http.get(
        url,
        headers: headers,
      );

      return _handleResponse(response);
    } catch (e) {
      throw ApiException('Network error: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> put({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');

      print('🔵 API Service: PUT $url');
      print('🔵 Request Body: $body');

      final defaultHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final response = await http.put(
        url,
        headers: headers ?? defaultHeaders,
        body: jsonEncode(body),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw ApiException(
            'Connection timeout. Please check your internet connection.',
          );
        },
      );

      print('🟢 API Service: Response Status: ${response.statusCode}');
      print('🟢 API Service: Response Body: ${response.body}');

      return _handleResponse(response);
    } on http.ClientException catch (e) {
      print('🔴 API Service: ClientException - $e');
      throw ApiException('Network connection failed. Please check internet.');
    } on FormatException catch (e) {
      print('🔴 API Service: FormatException - $e');
      throw ApiException('Invalid response from server.');
    } catch (e) {
      print('🔴 API Service: Unexpected error - $e');
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }


  Map<String, dynamic> _handleResponse(http.Response response) {
    try {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonResponse;
      } else {
        // Try to parse error message
        final message = jsonResponse['message'] ??
            jsonResponse['error'] ??
            'Request failed';
        throw ApiException(
          message,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Failed to parse response: ${e.toString()}');
    }
  }
  Future<Map<String, dynamic>> delete({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');

      print('🔵 API Service: DELETE $url');

      final defaultHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final response = await http.delete(
        url,
        headers: headers ?? defaultHeaders,
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw ApiException(
            'Connection timeout. Please check your internet connection.',
          );
        },
      );

      print('🟢 API Service: Response Status: ${response.statusCode}');
      print('🟢 API Service: Response Body: ${response.body}');

      return _handleResponse(response);
    } on http.ClientException catch (e) {
      print('🔴 API Service: ClientException - $e');
      throw ApiException('Network connection failed. Please check internet.');
    } on FormatException catch (e) {
      print('🔴 API Service: FormatException - $e');
      throw ApiException('Invalid response from server.');
    } catch (e) {
      print('🔴 API Service: Unexpected error - $e');
      if (e is ApiException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }


  Future<dynamic> getRaw({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');

      final response = await http.get(
        url,
        headers: headers,
      );

      return _handleRawResponse(response);
    } catch (e) {
      throw ApiException('Network error: ${e.toString()}');
    }
  }


  dynamic _handleRawResponse(http.Response response) {
    try {
      final decoded = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decoded; // <-- Can be List or Map
      } else {
        final message =
        (decoded is Map && decoded.containsKey('message'))
            ? decoded['message']
            : 'Request failed';

        throw ApiException(
          message,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Failed to parse response: ${e.toString()}');
    }
  }

}

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => message;
}