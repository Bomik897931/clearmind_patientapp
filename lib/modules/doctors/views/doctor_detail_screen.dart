import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../widgets/textWidget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../controller/locale_controller.dart';
import '../controllers/doctor_detail_controller.dart';

class DoctorDetailScreen extends StatefulWidget {
  const DoctorDetailScreen({super.key});

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();

    _youtubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
        "https://youtu.be/74DWwSxsVSs?si=g5cBMb3erVzzbs9H",
      )!,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DoctorDetailController>();
    final localeController = Get.find<LocaleController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () {
            if (Get.isSnackbarOpen) {
              Get.closeCurrentSnackbar();
            }

            if (Get.key.currentState?.canPop() == true) {
              Navigator.of(Get.context!).pop();
            }
          },
        ),
        centerTitle: false,
        // FIXED: Remove Obx wrapper since 'Doctor Details' is a static string
        title: mediumtext(text: 'Doctor Details', fontsize: 18),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.circularprogressindicator,
            ),
          );
        }

        if (controller.doctor.value == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: AppColors.grey400),
                const SizedBox(height: 16),
                Text(
                  'Failed to load doctor details',
                  style: TextStyle(color: AppColors.grey600, fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.refresh,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.circularprogressindicator,
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final doctor = controller.doctor.value!;

        return Padding(
          padding: const EdgeInsets.all(14),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Card
                Container(
                  padding: const EdgeInsets.only(top: 16, left: 16, bottom: 16),
                  decoration: BoxDecoration(
                    border: BoxBorder.all(color: AppColors.grey100),
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(Assets.doctorImage2),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 32,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    doctor.fullName,
                                    style: AppTextStyles.bodyLarge,
                                  ),
                                  Obx(
                                        () => IconButton(
                                      onPressed: () =>
                                          controller.toggleFavorite(doctor),
                                      icon: SvgPicture.asset(
                                        height: 26,
                                        width: 26,
                                        doctor.isFavorite.value
                                            ? Assets.fillFavIcon
                                            : Assets.likeIcon,
                                        colorFilter: ColorFilter.mode(
                                          doctor.isFavorite.value
                                              ? AppColors.red
                                              : AppColors.grey300,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            mediumtext(text: doctor.specialty, fontsize: 11),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 3,
                                horizontal: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.green,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(
                                "₹${doctor.fees}",
                                softWrap: true,
                                style: AppTextStyles.button,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Stats Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildStatCard(
                        icon: Assets.groupIcon,
                        value: '${doctor.patients}+',
                        label: 'Patients',
                      ),
                      const SizedBox(width: 24),
                      _buildStatCard(
                        icon: Assets.experienceIcon,
                        value: '${doctor.experienceYears}+',
                        label: 'Years experience',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // About Me Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   'Doctor Video',
                    //   style: TextStyle(
                    //     color: AppColors.textPrimary,
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ---- Title ----
                    Text(
                      'Doctor Video',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    // ---- Language Toggle ----
                    Obx(() {
                      final isEnglish =
                          controller.locale.languageCode == 'en';

                      return Container(
                        height: 28,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.primary),
                        ),
                        child: Row(
                          children: [
                            _langItem(
                              text: "English",
                              selected: isEnglish,
                              onTap: () =>
                                  controller.changeLocale(const Locale('en')),
                            ),
                            _langItem(
                              text: "हिंदी",
                              selected: !isEnglish,
                              onTap: () =>
                                  controller.changeLocale(const Locale('hi')),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),

                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: YoutubePlayer(
                          controller: _youtubeController,
                          showVideoProgressIndicator: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'About Doctor',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      doctor.about,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.grey700,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Language Spoken',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        specializationBox("Hindi"),
                        SizedBox(width: 5),
                        specializationBox("English"),
                        SizedBox(width: 5),
                        specializationBox("Marathi"),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Working Time Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Specialization',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // doctor.specialization.isEmpty
                    //     ? Text(
                    //   'No consultation charges available',
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     color: AppColors.grey600,
                    //   ),
                    // )
                    //     : Wrap(
                    //   spacing: 10,
                    //   runSpacing: 10,
                    //   children: doctor.specialization.map((spec) {
                    //     return specializationBox(
                    //       '${spec.sp} Min - ₹${spec.fee.toStringAsFixed(0)}',
                    //     );
                    //   }).toList(),
                    // ),
                    Row(
                      children: [
                        specializationBox("Anxiety"),
                        SizedBox(width: 5),
                        specializationBox("Depression"),
                        SizedBox(width: 5),
                        specializationBox("Stress"),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Reviews Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Consultation Charges',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    doctor.consultingFees.isEmpty
                        ? Text(
                      'No consultation charges available',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.grey600,
                      ),
                    )
                        : Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: doctor.consultingFees.map((fee) {
                        return _consultationChip(
                          '${fee.durationInMinutes} Min - ₹${fee.fee.toStringAsFixed(0)}',
                        );
                      }).toList(),
                    ),

                  ],
                ),

              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        color: AppColors.white,
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: controller.onBookAppointment,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.circularprogressindicator,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Book Appointment',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _langItem({
    required String text,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _consultationChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey200),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text('• $text', style: const TextStyle(fontSize: 12), softWrap: true),
    );
  }




  Widget specializationBox(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey200),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12), softWrap: true),
    );
  }

  Widget _buildStatCard({
    required String icon,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.grey100,
              borderRadius: BorderRadius.circular(30),
            ),
            child: SvgPicture.asset(icon),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.black87,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: AppColors.grey600),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}