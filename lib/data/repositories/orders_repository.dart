

import 'package:Clarminds/data/repositories/user_repository.dart';

import '../../core/constants/api_constants.dart';
import '../models/order_model.dart';
import '../services/api_service.dart';
class OrdersRepository {
  final ApiService _apiService;

  OrdersRepository({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  // Get all orders for current patient
  Future<List<OrderModel>> getMyOrders({required String token}) async {
    try {
      print('🔵 Repository: Fetching my orders');

      final response = await _apiService.get(
        endpoint: ApiConstants.myOrdersEndpoint, // '/Patient/my-order'
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Response: $response');
      print('RuntimeType: ${response.runtimeType}');

      List<dynamic> ordersList;

      if (response is List) {
        ordersList = response as List;
      } else      if (response['success'] == true && response['data'] is List) {
        ordersList = response['data'];
      } else if (response['data'] is List) {
        ordersList = response['data'];
      } else {
        throw RepositoryException(
          response['message'] ?? 'Expected "data" key containing List<dynamic>',
        );
      }
    

      final orders = ordersList
          .map((item) => OrderModel.fromJson(item))
          .toList();

      print('✅ Repository: Loaded ${orders.length} orders');
      return orders;

    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to fetch orders: ${e.toString()}');
    }
  }

  // Get order details by ID
  Future<OrderModel> getOrderById({
    required String token,
    required int orderId,
  }) async {
    try {
      print('🔵 Repository: Fetching order $orderId');

      final response = await _apiService.get(
        endpoint: '${ApiConstants.myOrderByIdEndpoint}/$orderId', // '/Patient/my-order-byId/{id}'
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Response: $response');
      print('RuntimeType: ${response.runtimeType}');

      Map<String, dynamic> orderData;

      if (response['success'] == true && response['data'] is Map<String, dynamic>) {
        orderData = response['data'];
      } else if (response['data'] is Map<String, dynamic>) {
        orderData = response['data'];
      } else {
        throw RepositoryException(
          response['message'] ?? 'Expected "data" key containing Map<String, dynamic>',
        );
      }
    
      final order = OrderModel.fromJson(orderData);
      print('✅ Repository: Order details loaded');
      return order;

    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to fetch order details: ${e.toString()}');
    }
  }
}