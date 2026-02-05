import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';
import '../../../data/models/address_model.dart';
import '../../../data/repositories/address_repository.dart';
import '../../../data/services/StorageService.dart';
class SaveAddressController extends GetxController {
  final AddressRepository _repo = AddressRepository();
  final StorageService _storage = StorageService();

  final Rxn<AddressModel> address = Rxn<AddressModel>();
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddress();
  }

  Future<void> fetchAddress() async {
    try {
      isLoading.value = true;
      final token = await _storage.getToken();
      final data = await _repo.getAddress(token!);

      if (data == null) {
        // No address → redirect to edit
        Get.offNamed(AppRoutes.editAddress);
      } else {
        address.value = data;
      }
    } finally {
      isLoading.value = false;
    }
  }

  void goToEdit() {
    Get.toNamed(
      AppRoutes.editAddress,
      arguments: address.value,
    );
  }
}
