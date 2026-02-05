import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../data/models/address_model.dart';
import '../../../data/repositories/address_repository.dart';
import '../../../data/services/StorageService.dart';

class EditAddressController extends GetxController {
  // ==============================
  // Repositories & Services
  // ==============================
  final AddressRepository _repository = AddressRepository();
  final StorageService _storage = StorageService();

  // ==============================
  // Text Controllers (FORM FIELDS)
  // ==============================
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController =
  TextEditingController(text: 'India');
  final TextEditingController zipCodeController = TextEditingController();

  // ==============================
  // STATE
  // ==============================
  final RxBool isLoading = false.obs;
  int? addressId;

  // ==============================
  // INIT
  // ==============================
  @override
  void onInit() {
    super.onInit();
    _prefillIfEdit();
  }

  /// If coming from Save Address screen → prefill data
  void _prefillIfEdit() {
    final AddressModel? address = Get.arguments;

    if (address != null) {
      addressId = address.addressId;
      streetController.text = address.street;
      cityController.text = address.city;
      stateController.text = address.state;
      countryController.text = address.country;
      zipCodeController.text = address.zipCode;
    }
  }

  // ==============================
  // SAVE (ADD / UPDATE)
  // ==============================
  Future<void> saveAddress() async {
    if (!_isFormValid()) return;

    try {
      isLoading.value = true;

      final token = await _storage.getToken();

      final AddressModel address = AddressModel(
        addressId: addressId,
        street: streetController.text.trim(),
        city: cityController.text.trim(),
        state: stateController.text.trim(),
        country: countryController.text.trim(),
        zipCode: zipCodeController.text.trim(),
        isPrimary: false,
      );

      if (addressId == null) {
        // ➕ ADD ADDRESS
        await _repository.addAddress(address, token!);
        Get.snackbar('Success', 'Address added successfully');
      } else {
        // ✏️ UPDATE ADDRESS
        await _repository.updateAddress(address, token!);
        Get.snackbar('Success', 'Address updated successfully');
      }

      // Go back to Save Address screen
      Get.offNamed(AppRoutes.SaveAddress);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ==============================
  // VALIDATION
  // ==============================
  bool _isFormValid() {
    if (streetController.text.isEmpty) {
      _error('Street / House No is required');
      return false;
    }
    if (cityController.text.isEmpty) {
      _error('City is required');
      return false;
    }
    if (stateController.text.isEmpty) {
      _error('State is required');
      return false;
    }
    if (zipCodeController.text.isEmpty) {
      _error('Pincode is required');
      return false;
    }
    return true;
  }

  void _error(String message) {
    Get.snackbar('Validation', message);
  }

  // ==============================
  // DISPOSE
  // ==============================
  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    zipCodeController.dispose();
    super.onClose();
  }
}
