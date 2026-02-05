import 'package:get/get.dart';
import '../../../data/models/order_model.dart';
import '../../../data/repositories/orders_repository.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../data/services/StorageService.dart';

class OrderDetailsController extends GetxController {
  final OrdersRepository _repository = OrdersRepository();
  final StorageService _storage = Get.find();

  // Observables
  final order = Rx<OrderModel?>(null);
  final isLoading = false.obs;
  late int orderId;

  @override
  void onInit() {
    super.onInit();
    // Get order ID from arguments
    final args = Get.arguments as Map<String, dynamic>;
    orderId = args['orderId'] as int;
    loadOrderDetails();
  }

  Future<void> loadOrderDetails() async {
    try {
      isLoading.value = true;

      final token = await _storage.getToken();
      if (token == null) {
        Get.snackbar('Error', 'Please login first');
        Get.offAllNamed('/login');
        return;
      }

      print('🔵 Controller: Loading order details for $orderId...');

      final loadedOrder = await _repository.getOrderById(
        token: token,
        orderId: orderId,
      );

      order.value = loadedOrder;

      print('✅ Controller: Order details loaded');
    } on RepositoryException catch (e) {
      print('❌ Controller: RepositoryException - ${e.message}');
      Get.snackbar(
        'Error',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      // Go back on error
      Future.delayed(Duration(seconds: 2), () => Get.back());
    } catch (e) {
      print('❌ Controller: Unexpected error - $e');
      Get.snackbar(
        'Error',
        'Failed to load order details',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      Future.delayed(Duration(seconds: 2), () => Get.back());
    } finally {
      isLoading.value = false;
    }
  }

  String formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }

  String formatDateTime(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day}-${months[date.month - 1]}-${date.year}';
  }

  // Get track status info
  Map<String, dynamic> getTrackInfo() {
    if (order.value == null) return {};

    final status = order.value!.status;

    switch (status) {
      case 'Placed':
        return {
          'currentStep': 0,
          'title': 'Order Placed',
          'subtitle': 'Your Order Has Been Received',
        };
      case 'Confirmed':
        return {
          'currentStep': 1,
          'title': 'Order Confirmed',
          'subtitle': 'Pharmacy Has Confirmed Your Medicines',
        };
      case 'Packed':
        return {
          'currentStep': 2,
          'title': 'Packed & Ready To Dispatch',
          'subtitle': 'Your Medicines Are Packed',
        };
      case 'Dispatched':
        return {
          'currentStep': 3,
          'title': 'Dispatched',
          'subtitle': 'On The Way [20234589]',
        };
      default:
        return {
          'currentStep': 0,
          'title': status,
          'subtitle': 'Check The Current Status Of Your Medicine Delivery',
        };
    }
  }

  @override
  void refresh() {
    loadOrderDetails();
  }
}