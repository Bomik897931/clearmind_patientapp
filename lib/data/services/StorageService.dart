// import 'package:get_storage/get_storage.dart';
// import 'dart:convert';
//
// import 'package:patient_app/data/models/uservc_model.dart';
//
// class StorageService {
//   static final StorageService _instance = StorageService._internal();
//   factory StorageService() => _instance;
//   StorageService._internal();
//
//   final _storage = GetStorage();
//
//   static const String _tokenKey = 'auth_token';
//   static const String _userKey = 'user_data';
//   static const String _isLoggedInKey = 'is_logged_in';
//
//   Future<void> init() async {
//     await GetStorage.init();
//   }
//
//   // Token Management
//   Future<void> saveToken(String token) async {
//     await _storage.write(_tokenKey, token);
//   }
//
//   String? getToken() {
//     return _storage.read(_tokenKey);
//   }
//
//   // User Data Management
//   Future<void> saveUser(UserVCModel user) async {
//     await _storage.write(_userKey, jsonEncode(user.toJson()));
//     await _storage.write(_isLoggedInKey, true);
//   }
//
//   UserVCModel? getUser() {
//     final userData = _storage.read(_userKey);
//     if (userData != null) {
//       return UserVCModel.fromJson(jsonDecode(userData));
//     }
//     return null;
//   }
//
//   // Login Status
//   bool isLoggedIn() {
//     return _storage.read(_isLoggedInKey) ?? false;
//   }
//
//   // Clear All Auth Data
//   Future<void> clearAuth() async {
//     await _storage.remove(_tokenKey);
//     await _storage.remove(_userKey);
//     await _storage.remove(_isLoggedInKey);
//   }
//
//   // Clear All Storage
//   Future<void> clearAll() async {
//     await _storage.erase();
//   }
// }


import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class StorageService {
  static const String _userKey = 'user_data';
  static const String _tokenKey = 'auth_token';

  Future<void> saveUser(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = jsonEncode(user.toJson());
      await prefs.setString(_userKey, userJson);
    } catch (e) {
      throw StorageException('Failed to save user data');
    }
  }

    Future<void> init() async {
    await GetStorage.init();
  }

  Future<User?> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);

      if (userJson != null) {
        final userMap = jsonDecode(userJson) as Map<String, dynamic>;
        return User.fromJson(userMap);
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.remove(_tokenKey);
  }
}

class StorageException implements Exception {
  final String message;
  StorageException(this.message);

  @override
  String toString() => message;
}
