import 'package:Clarminds/data/services/StorageService.dart';
import 'package:get/get.dart';

import '../../../data/models/cart_response_model.dart';
import '../../../data/repositories/cart_repository.dart';

class CartController extends GetxController {
  final CartRepository _repository;
  final StorageService _storage;

  CartController({
    CartRepository? repository,
    StorageService? storage,
  })  : _repository = repository ?? CartRepository(),
        _storage = storage ?? StorageService();

  /// STATES
  final isLoading = false.obs;
  final noRecordFound = false.obs;
  final cart = Rxn<CartResponse>();

  int? prescriptionId;

  /// 🚀 DO NOT LOAD HERE
  @override
  void onInit() {
    super.onInit();
    print('🟢 CartController onInit');
  }

  /// 🔥 MAIN ENTRY POINT (call this manually)
  Future<void> handleEntry({dynamic args}) async {
    print('🟣 handleEntry called with args: $args');

    // RESET OLD STATE
    cart.value = null;
    noRecordFound.value = false;
    prescriptionId = null;

    if (args is int) {
      prescriptionId = args;
      await fetchCartByPrescription();
    } else if (args is Map && args['prescriptionId'] != null) {
      prescriptionId = args['prescriptionId'];
      await fetchCartByPrescription();
    } else {
      // 👉 Bottom nav direct entry
      await fetchMyCartDetail();
    }
  }

  /// 🔹 CART BY PRESCRIPTION
  Future<void> fetchCartByPrescription() async {
    try {
      print('🟡 fetchCartByPrescription START');

      isLoading.value = true;

      final token = await _storage.getToken();
      if (token == null) {
        Get.offAllNamed('/login');
        return;
      }

      final response = await _repository.getCart(
        prescriptionId: prescriptionId!,
        token: token,
      );

      if (response.orderItems.isEmpty) {
        noRecordFound.value = true;
        return;
      }

      cart.value = response;
      print('✅ Cart loaded via prescription');

    } catch (e, s) {
      print('❌ fetchCartByPrescription ERROR: $e');
      print(s);
      noRecordFound.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  /// 🔹 DIRECT CART
  Future<void> fetchMyCartDetail() async {
    try {
      print('🟡 fetchMyCartDetail START');

      isLoading.value = true;

      final token = await _storage.getToken();
      if (token == null) {
        Get.offAllNamed('/login');
        return;
      }

      final response = await _repository.getMyCartDetail(token: token);

      print('🟢 OrderItems: ${response.orderItems.length}');

      if (response.orderItems.isEmpty) {
        noRecordFound.value = true;
        return;
      }

      cart.value = response;
      print('✅ Cart loaded via my-cart-detail');

    } catch (e, s) {
      print('❌ fetchMyCartDetail ERROR: $e');
      print(s);
      noRecordFound.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
