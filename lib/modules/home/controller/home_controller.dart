import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../data/repositories/doctor_repository.dart';
import '../../../data/models/doctor_model.dart';
import '../../../data/models/category_model.dart';
import '../../../data/services/StorageService.dart';

class HomeController extends GetxController {
  final RxList<Specialization> specializations = <Specialization>[].obs;
  final RxList<DoctorModel> doctors = <DoctorModel>[].obs;
  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool isSearching = false.obs;
  final RxInt selectedBottomIndex = 0.obs;
  final StorageService _storage = StorageService();
  final DoctorsRepository _doctorsRepository = DoctorsRepository();
  // Search Controller
  final searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();


  // Pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final hasNext = false.obs;
  final hasPrevious = false.obs;
  final totalCount = 0.obs;

  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();

    _loadSpecializations();
    loadDoctors();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100) {
        if (hasNext.value && !isLoading.value && !isSearching.value) {
          nextPage();
        }
      }
    });
  }

  @override
  void onClose() {
    _debounce?.cancel();
    // searchController.dispose();
    super.onClose();
  }

  Future<void> _loadSpecializations() async {
    isLoading.value = true;
    try {
      final token = await _storage.getToken();

      if (token == null) {
        return;
      }

      print('🔵 Controller: Fetching specializations...');

      final response = await _doctorsRepository.getSpecializations(
        token: token,
      );

      specializations.value = response;
      isLoading.value = false;

      // Add "All" option at the beginning
      // specializations.insert(0, Specialization(
      //   specializationId: 0,
      //   specializationName: 'All',
      // ));

      print('🟢 Controller: Loaded ${response.length} specializations');
    } catch (e) {
      isLoading.value = false;
      print('🔴 Controller: Error loading specializations - $e');
      // Use fallback static data if API fails
      specializations.value = [
        Specialization(
          specializationId: 1,
          specializationName: 'Psychologistt',
        ),
        Specialization(
          specializationId: 2,
          specializationName: 'Psychiatristt',
        ),
        Specialization(specializationId: 3, specializationName: 'Therapistt'),
      ];
    }
  }



  void onSearchChanged(String query) {
    searchQuery.value = query;
    // Implement search logic here
    // Cancel previous timer
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Create new timer (wait 500ms after user stops typing)
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        // If search is cleared, load all doctors
        loadDoctors(page: 1);
      } else {
        // Search with the query
        loadDoctors(page: 1, search: query);
      }
    });
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    loadDoctors(page: 1);
  }


  void onSpecializationTap(Specialization specialization) {
    // Navigate to doctors list filtered by specialization
    Get.toNamed(
      '/doctors-by-specialization',
      arguments: {'specialization': specialization},
    );
  }

  void onFavoriteTap() {
    Get.toNamed(AppRoutes.FAVORITE_DOCTORS);
  }

  void onNotificationTap() {
    Get.toNamed(AppRoutes.NOTIFICATIONS);
  }

  void onCategoryTap(Specialization category) {
    if (category.specializationName == 'More') {
      Get.toNamed('/categories');
    } else {
      // Navigate to filtered doctors by category
      Get.toNamed(
        '/top-doctors',
        arguments: {'category': category.specializationName},
      );
    }
  }

  void onDoctorTap(DoctorModel doctor) {
    Get.toNamed('/doctor-detail', arguments: {'doctor': doctor});
  }

  // void toggleFavorite(DoctorModel doctor) {
  //   final index = topDoctors.indexWhere((d) => d.id == doctor.id);
  //   if (index != -1) {
  //     topDoctors[index] = doctor.copyWith(isFavorite: !doctor.isFavorite);
  //     topDoctors.refresh();
  //   }
  // }

  void onBottomNavTap(int index) {
    selectedBottomIndex.value = index;
    switch (index) {
      case 0:
        // Already on home
        break;
      case 1:
        Get.toNamed('/my-appointments');
        break;
      case 2:
        // Favorites screen
        Get.toNamed('/all-slots');
        break;
        break;
      case 3:
        Get.toNamed('/profile');
        break;
    }
  }

  // Future<void> loadDoctors({
  //   int page = 1,
  //   int pageSize = 10,
  //   String? search,
  // }) async {
  //   try {
  //     isLoading.value = true;
  //
  //     final token = await _storage.getToken();
  //
  //     if (token == null) {
  //       Get.snackbar('Error', 'Please login first');
  //       Get.offAllNamed('/login');
  //       return;
  //     }
  //
  //     print('🔵 Controller: Fetching doctors...');
  //
  //     final response = await _doctorsRepository.getDoctors(
  //       token: token,
  //       specialization: 'all',
  //       pageNumber: page,
  //       pageSize: pageSize,
  //     );
  //
  //     doctors.value = response.items;
  //     // currentPage.value = response.pageNumber;
  //     // totalPages.value = response.totalPages;
  //     // hasNext.value = response.hasNext;
  //     // hasPrevious.value = response.hasPrevious;
  //     // totalCount.value = response.totalCount;
  //
  //     print('🟢 Controller: Fetched ${response.items.length} doctors');
  //
  //   } catch (e) {
  //     print('🔴 Controller: Error - $e');
  //     Get.snackbar('Error', 'Failed to load doctors');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> loadDoctors({
    int page = 1,
    int pageSize = 10,
    String? search,
  }) async {
    try {
      if (search != null) {
        isSearching.value = true;
      } else {
        isLoading.value = true;
      }

      final token = await _storage.getToken();

      if (token == null) {
        Get.snackbar('Error', 'Please login first');
        Get.offAllNamed('/login');
        return;
      }

      print('🔵 Controller: Fetching doctors (search: $search)...');

      final response = await _doctorsRepository.getDoctors(
        token: token,
        specialization: 'all',
        pageNumber: page,
        pageSize: pageSize,
        search: search,
      );

      // doctors.value = response.items;
      if (page == 1) {
        doctors.value = response.items;
      } else {
        doctors.addAll(response.items);
      }

      currentPage.value = response.pageNumber;
      totalPages.value = response.totalPages;
      hasNext.value = response.hasNext;
      hasPrevious.value = response.hasPrevious;
      totalCount.value = response.totalCount;

      print('🟢 Controller: Fetched ${response.items.length} doctors');
    } catch (e) {
      print('🔴 Controller: Error - $e');
      Get.snackbar(
        'Error',
        'Failed to load doctors',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void nextPage() {
    if (hasNext.value) {
      loadDoctors(
        page: currentPage.value + 1,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
      );
    }
  }

  void previousPage() {
    if (hasPrevious.value) {
      loadDoctors(
        page: currentPage.value - 1,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
      );
    }
  }

  @override
  void refresh() {
    loadDoctors(
      page: 1,
      search: searchQuery.value.isEmpty ? null : searchQuery.value,
    );
  }
}
