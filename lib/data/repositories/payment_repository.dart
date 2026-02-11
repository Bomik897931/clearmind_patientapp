import 'package:flutter/material.dart';
import '../models/api_response.dart';
import '../services/api_service.dart';

class PaymentRepository {
  final ApiService _apiService;

  PaymentRepository({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<bool> confirmPayment({
    required int appointmentId,
    required int amount,
    required String paymentId,
    String? orderId,
    String? signature,
    required String token,
  }) async {
    try {
      debugPrint('📤 ========== PAYMENT CONFIRMATION REQUEST ==========');
      debugPrint('Endpoint: Patient/confirm-payment');
      debugPrint('Method: POST');
      debugPrint('Headers: {');
      debugPrint('  Authorization: Bearer ${token.substring(0, 20)}...');
      debugPrint('  Content-Type: application/json');
      debugPrint('}');
      debugPrint('Body: {');
      debugPrint('  appointmentId: $appointmentId,');
      debugPrint('  amount: $amount,');
      debugPrint('  currency: INR,');
      debugPrint('  razorpayPaymentId: $paymentId,');
      debugPrint('  razorpayOrderId: ${orderId ?? ""},');
      debugPrint('  razorpaySignature: ${signature ?? ""},');
      debugPrint('  paymentMethod: ONLINE');
      debugPrint('}');

      final response = await _apiService.post(
        // Try different endpoint variations
        endpoint: "Patient/confirm-payment", // Relative path
        // endpoint: "/Patient/confirm-payment", // With leading slash
        // endpoint: "/api/Patient/confirm-payment", // Full path
        body: {
          "appointmentId": appointmentId,
          "amount": amount,
          "currency": "INR",
          "razorpayPaymentId": paymentId,
          "razorpayOrderId": orderId ?? "",
          "razorpaySignature": signature ?? "",
          "paymentMethod": "ONLINE",
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      debugPrint('📥 ========== PAYMENT CONFIRMATION RESPONSE ==========');
      debugPrint('Response: $response');
      debugPrint('Response Type: ${response.runtimeType}');

      // Handle empty or null response
      if (response == null) {
        debugPrint('🔴 Response is null');
        throw RepositoryException('Server returned empty response');
      }

      final apiResponse = ApiResponse.fromJson(response);

      debugPrint('API Response Success: ${apiResponse.success}');
      debugPrint('API Response Message: ${apiResponse.message}');
      debugPrint('API Response Data: ${apiResponse.data}');

      if (apiResponse.success) {
        debugPrint('✅ Payment confirmed successfully');
        return true;
      } else {
        debugPrint('🔴 Payment confirmation failed: ${apiResponse.message}');
        throw RepositoryException(apiResponse.message ?? 'Failed to confirm payment');
      }
    } on ApiException catch (e) {
      debugPrint('🔴 ========== API EXCEPTION ==========');
      debugPrint('Message: ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      debugPrint('🔴 ========== UNEXPECTED ERROR ==========');
      debugPrint('Error: $e');
      debugPrint('Error Type: ${e.runtimeType}');

      // Better error message for 404
      if (e.toString().contains('404')) {
        throw RepositoryException('Payment endpoint not found. Please check with backend team.');
      }

      throw RepositoryException('Failed to confirm payment: ${e.toString()}');
    }
  }
}

class RepositoryException implements Exception {
  final String message;
  RepositoryException(this.message);

  @override
  String toString() => message;
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}