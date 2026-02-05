import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/order_model.dart';
import '../../../data/repositories/orders_repository.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../data/services/StorageService.dart';

class MyOrdersController extends GetxController {

  final OrdersRepository _repository = OrdersRepository();
  final StorageService _storage = Get.find();

  // Observables
  final orders = <OrderModel>[].obs;
  final filteredOrders = <OrderModel>[].obs;
  final isLoading = false.obs;
  final searchQuery = ''.obs;

  // Search controller
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadOrders();

    // Listen to search changes
    searchController.addListener(() {
      searchQuery.value = searchController.text;
      filterOrders();
    });
  }

  Future<void> loadOrders() async {
    try {
      isLoading.value = true;

      final token = await _storage.getToken();
      if (token == null) {
        Get.snackbar('Error', 'Please login first');
        Get.offAllNamed('/login');
        return;
      }

      print('🔵 Controller: Loading orders...');

      final loadedOrders = await _repository.getMyOrders(token: token);

      orders.value = loadedOrders;
      filteredOrders.value = loadedOrders;

      print('✅ Controller: ${orders.length} orders loaded');
    } on RepositoryException catch (e) {
      print('❌ Controller: RepositoryException - ${e.message}');
      Get.snackbar(
        'Error',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } catch (e) {
      print('❌ Controller: Unexpected error - $e');
      Get.snackbar(
        'Error',
        'Failed to load orders',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void filterOrders() {
    if (searchQuery.value.isEmpty) {
      filteredOrders.value = orders;
    } else {
      filteredOrders.value = orders.where((order) {
        final query = searchQuery.value.toLowerCase();
        // You can add more search criteria here
        return order.orderId.toString().contains(query) ||
            order.status.toLowerCase().contains(query);
      }).toList();
    }
  }

  void onOrderTap(OrderModel order) {
    Get.toNamed('/order-details', arguments: {'orderId': order.orderId});
  }

  @override
  void refresh() {
    loadOrders();
  }

  String formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day}/${date.month}/${date.year.toString().substring(2)}';
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}