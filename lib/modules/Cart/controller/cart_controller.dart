import 'package:get/get.dart';
import '../../../data/models/cart_response_model.dart';
import '../../../data/repositories/cart_repository.dart';
import '../../../data/services/StorageService.dart';
import '../../../core/constants/app_colors.dart';

class CartController extends GetxController {
  // final CartRepository _repository = Get.find<CartRepository>();
  // final StorageService _storage = Get.find<StorageService>();
  final CartRepository _repository;
  final StorageService _storage;

  CartController({
    CartRepository? repository,
    StorageService? storage,
  }) : _repository = repository ?? CartRepository(),
        _storage = storage ?? StorageService();

  // Observables
  var isLoading = false.obs;
  var cart = Rxn<CartResponse>();

  // Prescription ID (will be set from arguments)
  late int prescriptionId;

  @override
  void onInit() {
    super.onInit();
    _loadArguments();
  }

  void _loadArguments() {
    try {
      final args = Get.arguments;

      if (args == null) {
        print('❌ No arguments received');
        Get.snackbar(
          'Error',
          'Prescription ID not provided',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
        );
        Future.delayed(Duration(seconds: 2), () => Get.back());
        return;
      }

      // Handle different argument formats
      if (args is Map<String, dynamic>) {
        prescriptionId = args['prescriptionId'] as int;
      } else if (args is int) {
        prescriptionId = args;
      } else {
        throw Exception('Invalid argument type');
      }

      print('✅ Prescription ID loaded: $prescriptionId');

      // Now fetch cart
      fetchCart();
    } catch (e) {
      print('❌ Error loading arguments: $e');
      Get.snackbar(
        'Error',
        'Failed to load cart data',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      Future.delayed(Duration(seconds: 2), () => Get.back());
    }
  }

  Future<void> fetchCart() async {
    try {
      isLoading.value = true;

      final token = await _storage.getToken();
      if (token == null) {
        Get.snackbar(
          'Error',
          'Login required',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
        );
        Get.offAllNamed('/login');
        return;
      }

      print('🔵 Controller: Fetching cart for prescription $prescriptionId');

      cart.value = await _repository.getCart(
        prescriptionId: prescriptionId,
        token: token,
      );

      print('✅ Controller: Cart loaded successfully');
    } catch (e) {
      print('❌ Controller: Error fetching cart - $e');
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refresh() async {
    await fetchCart();
  }
}