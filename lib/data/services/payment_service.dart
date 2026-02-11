import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../core/constants/api_constants.dart';
import '../../core/constants/app_colors.dart';

class PaymentService {
  late Razorpay _razorpay;

  // Callbacks
  Function(Map<String, dynamic>)? onPaymentSuccess;
  Function(String)? onPaymentError;
  Function(String)? onExternalWallet;

  PaymentService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    debugPrint('✅ Payment Success!');
    debugPrint('Payment ID: ${response.paymentId}');
    debugPrint('Order ID: ${response.orderId}');
    debugPrint('Signature: ${response.signature}');

    // Prepare data for backend verification
    final paymentData = {
      'razorpay_payment_id': response.paymentId,
      'razorpay_order_id': response.orderId,
      'razorpay_signature': response.signature,
    };

    // In a real app, you would verify with backend here
    // await _verifyPaymentWithBackend(paymentData);

    if (onPaymentSuccess != null) {
      onPaymentSuccess!(paymentData);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint('❌ Payment Error: ${response.code} - ${response.message}');

    if (onPaymentError != null) {
      onPaymentError!(response.message ?? 'Payment failed');
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('📱 External Wallet: ${response.walletName}');

    if (onExternalWallet != null) {
      onExternalWallet!(response.walletName ?? 'Unknown wallet');
    }
  }

  // Method to verify payment with backend (optional - for when backend is ready)
  // Future<bool> _verifyPaymentWithBackend(Map<String, dynamic> paymentData) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse(AppConstants.verifyPaymentUrl),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode(paymentData),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       return data['verified'] == true;
  //     }
  //   } catch (e) {
  //     debugPrint('Error verifying payment: $e');
  //   }
  //   return false;
  // }

  // Method to create order on backend (optional - for when backend is ready)
  // Future<String?> createOrder(double amount) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse(AppConstants.createOrderUrl),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'amount': amount}),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       return data['id'];
  //     }
  //   } catch (e) {
  //     debugPrint('Error creating order: $e');
  //   }
  //   return null;
  // }

  // Open Razorpay checkout
  void openCheckout({
    required double amount,
    required String name,
    required String description,
    String? email,
    String? contact,
    String? orderId,
  }) {
    var options = {
      'key': 'rzp_test_S5fKChprzBGn5e',
      'amount': (amount * 100).toInt(), // Amount in paise
      'name': "CM",
      'description': description,
      'timeout': 300, // 5 minutes
      'currency': 'INR',
      // 🔥 VERY IMPORTANT
      'method': {
        'upi': false,
        'wallet': false,
        'netbanking': false,
        'card': true,
      },
      'prefill': {
        'contact': contact ?? '',
        'email': email ?? '',
        'name': name,
      },
      'theme': {
        'color': '#${AppColors.razorpayColor.toRadixString(16).padLeft(6, '0')}'
      }
    };

    print(options);

    // Add order ID if provided
    if (orderId != null && orderId.isNotEmpty) {
      options['order_id'] = orderId;
    }

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error opening Razorpay: $e');
      if (onPaymentError != null) {
        onPaymentError!('Error opening payment gateway');
      }
    }
  }

  void dispose() {
    _razorpay.clear();
  }
}