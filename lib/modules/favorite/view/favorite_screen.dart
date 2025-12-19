import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/models/favorite_model.dart';
import '../../../widgets/bottom_nav_bar.dart';
import '../controller/favorite_controller.dart';

class FavoriteDoctorsScreen extends GetView<FavoriteDoctorsController> {
  const FavoriteDoctorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'My Favourite Doctor',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.circularprogressindicator,
            ),
          );
        }

        if (controller.favoriteDoctors.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'No favorite doctors yet',
                  style: TextStyle(color: AppColors.grey600, fontSize: 16),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refresh,
          color:  AppColors.circularprogressindicator,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.favoriteDoctors.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final doctor = controller.favoriteDoctors[index];
              return _buildDoctorCard(doctor);
            },
          ),
        );
      }),
      bottomNavigationBar: Obx(
            () => BottomNavBar(currentIndex: controller.selectedBottomIndex.value),
      ),
    );
  }

  Widget _buildDoctorCard(FavoriteDoctorModel doctor) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => controller.onDoctorTap(doctor),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Doctor Image
                Container(
                  width: 100,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color:  AppColors.circularprogressindicator.withOpacity(0.1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _isValidUrl(doctor.imageUrl)
                        ? Image.network(
                      doctor.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholder(doctor.doctorName);
                      },
                    )
                        : _buildPlaceholder(doctor.doctorName),
                  ),
                ),
                const SizedBox(width: 16),
                // Doctor Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        doctor.doctorName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${doctor.specialty} | Christ Hospital',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.grey600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            size: 18,
                            color: AppColors.orange,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              '${doctor.rating} (${doctor.formattedReviews} reviews)',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.grey700,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Favorite Button
                IconButton(
                  onPressed: () => controller.showRemoveDialog(doctor),
                  icon: const Icon(
                    Icons.favorite,
                    color: AppColors.circularprogressindicator,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isValidUrl(String url) {
    if (url.isEmpty || url == 'string' || url == 'image url' || url == 'Image Url') {
      return false;
    }
    return Uri.tryParse(url)?.hasScheme ?? false;
  }

  Widget _buildPlaceholder(String name) {
    return Container(
      color:  AppColors.circularprogressindicator.withOpacity(0.1),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : 'D',
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: AppColors.circularprogressindicator,
          ),
        ),
      ),
    );
  }
}