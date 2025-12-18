// import 'package:get/get.dart';
// import '../../../data/models/doctor_model.dart';
//
// class TopDoctorsController extends GetxController {
//   final RxList<DoctorModel> doctors = <DoctorModel>[].obs;
//   final RxBool isLoading = false.obs;
//   final RxString selectedCategory = ''.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     final args = Get.arguments;
//     if (args != null && args['category'] != null) {
//       selectedCategory.value = args['category'];
//     }
//     loadDoctors();
//   }
//
//   void loadDoctors() {
//     isLoading.value = true;
//
//     // Mock data - Replace with API call
//     doctors.value = List.generate(
//       10,
//       (index) => DoctorModel(
//         id: '${index + 1}',
//         name: index % 2 == 0 ? 'Dr. Drake Boeson' : 'Dr. Antonia Warner',
//         specialty: 'Cardiologist',
//         hospital: index % 3 == 0
//             ? 'Christ Hospital'
//             : index % 3 == 1
//             ? 'Franklin Hospital'
//             : 'Valley Hospital',
//         image: '',
//         rating: 4.9 - (index * 0.1),
//         reviewCount: 4945 - (index * 100),
//         experience: 5 + index,
//       ),
//     );
//
//     isLoading.value = false;
//   }
//
//   void onDoctorTap(DoctorModel doctor) {
//     Get.toNamed('/doctor-detail', arguments: {'doctor': doctor});
//   }
//
//   void toggleFavorite(DoctorModel doctor) {
//     final index = doctors.indexWhere((d) => d.id == doctor.id);
//     if (index != -1) {
//       doctors[index] = doctor.copyWith(isFavorite: !doctor.isFavorite);
//       doctors.refresh();
//     }
//   }
// }


// lib/modules/doctors/controllers/top_doctors_controller.dart
import 'package:get/get.dart';

import '../../../data/models/doctor_model.dart';
import '../../../data/repositories/doctor_repository.dart';
import '../../../data/services/StorageService.dart';

class TopDoctorsController extends GetxController {
  final DoctorsRepository _doctorsRepository;
  final StorageService _storage;

  TopDoctorsController({
    DoctorsRepository? doctorsRepository,
    StorageService? storage,
  })  : _doctorsRepository = doctorsRepository ?? DoctorsRepository(),
        _storage = storage ?? StorageService();

  final RxList<DoctorModel> doctors = <DoctorModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedCategory = ''.obs;

  // Pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final hasNext = false.obs;
  final hasPrevious = false.obs;
  final totalCount = 0.obs;

  // Favorites (stored locally)
  final RxSet<int> favoriteIds = <int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // Get arguments if passed from previous screen
    final args = Get.arguments;
    if (args != null && args['category'] != null) {
      selectedCategory.value = args['category'];
    }
    loadDoctors();
    _loadFavorites();
  }

  Future<void> loadDoctors({
    int page = 1,
    int pageSize = 10,
    String? specialization,
  }) async {
    try {
      isLoading.value = true;

      final token = await _storage.getToken();

      if (token == null) {
        Get.snackbar('Error', 'Please login first');
        Get.offAllNamed('/login');
        return;
      }

      print('🔵 Controller: Fetching doctors...');

      final response = await _doctorsRepository.getDoctors(
        token: token,
        specialization: specialization ?? selectedCategory.value.toLowerCase(),
        pageNumber: page,
        pageSize: pageSize,
      );
      print('🔵 Controller: Fetching doctors...$response');
      print('wertyu  ${specialization ?? selectedCategory.value.toLowerCase()}');
      doctors.value = response.items;
      currentPage.value = response.pageNumber;
      totalPages.value = response.totalPages;
      hasNext.value = response.hasNext;
      hasPrevious.value = response.hasPrevious;
      totalCount.value = response.totalCount;

      print('🟢 Controller: Fetched ${response.items.length} doctors');

    } catch (e) {
      print('🔴 Controller: Error - $e');
      Get.snackbar('Error', 'Failed to load doctors');
    } finally {
      isLoading.value = false;
    }
  }

  void onDoctorTap(DoctorModel doctor) {
    Get.toNamed('/doctor-detail', arguments: {'doctor': doctor});
  }

  void toggleFavorite(DoctorModel doctor) {
    if (favoriteIds.contains(doctor.userId)) {
      favoriteIds.remove(doctor.userId);
    } else {
      favoriteIds.add(doctor.userId);
    }
    _saveFavorites();
    doctors.refresh(); // Trigger UI update
  }

  bool isFavorite(DoctorModel doctor) {
    return favoriteIds.contains(doctor.userId);
  }

  Future<void> _loadFavorites() async {
    // Load from local storage
    // Implementation depends on your storage preference
  }

  Future<void> _saveFavorites() async {
    // Save to local storage
    // Implementation depends on your storage preference
  }

  void nextPage() {
    if (hasNext.value) {
      loadDoctors(page: currentPage.value + 1);
    }
  }

  void previousPage() {
    if (hasPrevious.value) {
      loadDoctors(page: currentPage.value - 1);
    }
  }

  void refresh() {
    loadDoctors(page: 1);
  }

  void filterBySpecialization(String specialization) {
    selectedCategory.value = specialization;
    loadDoctors(page: 1, specialization: specialization);
  }
}