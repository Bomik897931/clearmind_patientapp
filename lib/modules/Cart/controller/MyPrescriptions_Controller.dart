import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/cart_repository.dart';
import '../../../data/models/prescription_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../data/services/StorageService.dart';

class MyPrescriptionsController extends GetxController {
  // final CartRepository _repository = Get.find();
  // final StorageService _storage = Get.find();
  final CartRepository _repository;
  final StorageService _storage;

  MyPrescriptionsController({
    CartRepository? repository,
    StorageService? storage,
  }) : _repository = repository ?? CartRepository(),
        _storage = storage ?? StorageService();

  // Observables
  final prescriptions = <PrescriptionModel>[].obs;
  final isLoading = false.obs;
  final isLoadingMore = false.obs;

  // Pagination
  final currentPage = 1.obs;
  final totalPages = 0.obs;
  final hasMore = false.obs;
  final pageSize = 10;

  // Scroll controller for pagination
  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    loadPrescriptions();

    // Setup scroll listener for pagination
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      // Near bottom, load more
      if (!isLoadingMore.value && hasMore.value) {
        loadMore();
      }
    }
  }

  Future<void> loadPrescriptions({bool refresh = false}) async {
    if (refresh) {
      currentPage.value = 1;
      prescriptions.clear();
    }

    try {
      isLoading.value = true;

      final token = await _storage.getToken();
      if (token == null) {
        Get.snackbar('Error', 'Please login first');
        Get.offAllNamed('/login');
        return;
      }

      print('🔵 Controller: Loading prescriptions (Page: ${currentPage.value})');

      final response = await _repository.getMyPrescriptions(
        token: token,
        pageNumber: currentPage.value,
        pageSize: pageSize,
      );

      if (refresh) {
        prescriptions.value = response.items;
      } else {
        prescriptions.addAll(response.items);
      }

      totalPages.value = response.totalPages;
      hasMore.value = response.hasNext;

      print('✅ Controller: ${prescriptions.length} prescriptions loaded');
      print('   Page ${currentPage.value} of ${totalPages.value}');
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
        'Failed to load prescriptions',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore() async {
    if (!hasMore.value || isLoadingMore.value) return;

    try {
      isLoadingMore.value = true;
      currentPage.value++;

      final token = await _storage.getToken();
      if (token == null) return;

      print('🔵 Controller: Loading more (Page: ${currentPage.value})');

      final response = await _repository.getMyPrescriptions(
        token: token,
        pageNumber: currentPage.value,
        pageSize: pageSize,
      );

      prescriptions.addAll(response.items);
      hasMore.value = response.hasNext;

      print('✅ Controller: Loaded ${response.items.length} more prescriptions');
    } on RepositoryException catch (e) {
      print('❌ Controller: Failed to load more - ${e.message}');
      currentPage.value--; // Revert page number
    } catch (e) {
      print('❌ Controller: Unexpected error - $e');
      currentPage.value--; // Revert page number
    } finally {
      isLoadingMore.value = false;
    }
  }

  void onPrescriptionTap(PrescriptionModel prescription) {
    // Navigate to prescription detail with prescriptionId
    Get.toNamed(
      '/cartScreen',
      arguments: {'prescriptionId': prescription.prescriptionId},
    );
  }

  Future<void> refresh() async {
    await loadPrescriptions(refresh: true);
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
    scrollController.dispose();
    super.onClose();
  }
}